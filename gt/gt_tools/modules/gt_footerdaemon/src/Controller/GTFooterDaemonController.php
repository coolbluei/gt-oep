<?php

namespace Drupal\gt_footerdaemon\Controller;

use Drupal\Core\Controller\ControllerBase;
use Drupal\menu_link_content\Entity\MenuLinkContent;

class GTFooterDaemonController extends ControllerBase {

  // const GT_FOOTERDAEMON_VERSION = '1.0';

  /**
   * [protected description]
   * @var [type]
   */
  protected $menuLinkManager;

  /**
   * [__construct description]
   * @param EntityManagerInterface   $entity_manager    [description]
   * @param MenuLinkManagerInterface $menu_link_manager [description]
   */
  public function __construct() {
    $this->menuLinkManager = \Drupal::service('plugin.manager.menu.link');
  }

  /**
   * [get_remote_data description]
   * @return [type] [description]
   */
  public function get_remote_data() {

    // TODO: inject this fucking thing instead of calling statically
    $config = \Drupal::config('gt_footerdaemon.settings');
    $source = $config->get('data_source');

    $ch = $this->curl_setup($source);

    $data['data'] = curl_exec($ch);
    $data['info'] = curl_getinfo($ch);
    $data['err'] = curl_error($ch);
    curl_close($ch);

    $output = $this->parse_data($data['data']);

    return [
      '#markup' => t($output),
    ];
  }

  /**
   * [parse_data description]
   * @param  [type] $raw [description]
   * @return [type]      [description]
   */
  function parse_data($raw) {
    $elements = explode(PHP_EOL, $raw);

    $menu_array = [];
    $level = 0;
    $parent = '';
    $parent_stack = ['root'];

    // Build an array from the stupidly-formatted imported data.
    foreach ($elements as $element) {
      if ($element == '') { continue; }
      // Break each element into title, url, and weight. These each have to be
      // cleaned up because the exporter doesn't quite do json, but rather
      // something that looks vaguely like json.
      list($title, $parameters) = explode(' {', $element);
      list($url, $weight) = explode('","', $parameters);
      $url = substr($url, 7);
      $url = str_replace('\\', '', $url);
      $weight = substr($weight, 9);
      $weight = rtrim($weight, '"}');

      // Children are designated with dashes corresponding to the level of
      // nesting. Deal with it.
      // First off, everything is at least a child of root, so the default level
      // is 1.
      $level = 1;
      // No initial parent
      $parent = '';
      // Trim dashes and keep track of how many we've trimmed.
      while (substr($title, 0, 1) === '-') {
        $title = substr($title, 1);
        $level++;
      }
      // The parent of this item is the element at the previous level.
      $parent = $parent_stack[$level - 1];
      // This element is the current parent at this level.
      $parent_stack[$level] = $title;

      // Stuff all the bits into the menu array.
      array_push($menu_array,
        [
          'title' => $title,
          'parent' => $parent,
          'url' => $url,
          'weight' => $weight,
        ]
      );

      // In case this needs to be debugged.
      // dpm($title, 'element');
      // dpm($parent, 'parent');
      // dpm($level, 'level');
      // dpm($parent_stack, 'parents');
    }

    // Write the menu to a file.
    $this->write_menu($menu_array);

    return 'OK';
  }

  /**
   * [write_menu description]
   * @param  [type] $menu_array [description]
   * @return [type]             [description]
   */
  function write_menu($menu_array) {
    // Delete existing links
    // TODO: This sucks. Better would be to update existing links; That way we
    // don't lose whatever modifications the user makes -- for example, if the
    // user doesn't want certain links to show up.
    for ($i = 0; $i < 4; $i++) {
      $this->menuLinkManager->deleteLinksInMenu('gt_footer_menu_' . $i);
    }

    // Loop through $menu array and create a link for each item.
    $parents = [];
    $menu_block = 0;
    foreach ($menu_array as $link) {
      // TODO: <nolink> and <separator> need to be handled intelligently.
      if ($link['url'] == '<nolink>') { $link['url'] = 'route:<nolink>'; }
      if ($link['title'] == 'BREAK') {
        $menu_block++;
        continue;
      }
      if ($link['url'] == '') { continue; }

      // Make a link...
      $menu_link = MenuLinkContent::create([
        'title' => $link['title'],
        'link' => ['uri' => $link['url']],
        'weight' => $link['weight'],
        'parent' => $link['parent'] != 'root' ? $parents[$link['parent']] : '',
        'menu_name' => 'gt_footer_menu_' . $menu_block,
        'expanded' => TRUE,
      ]);

      if ($link['url'] == 'http://yahoo.com') { $menu_link->link->first()->options = ['attributes' => ['class' => ['no-link']]]; }

      // ... and save it.
      $menu_link->save();

      // Store link IDs for future reference by child items.
      if (!isset($parents[$link['title']])) {
        $parents[$link['title']] = $menu_link->getPluginId();
      }
    }
  }

  /**
   * [curl_setup description]
   * @param  [type] $url [description]
   * @return [type]      [description]
   */
  public function curl_setup($url) {
    $ch = curl_init();

    // see: http://www.php.net/manual/en/function.curl-setopt.php#102121
    $mr = 5;
    $rch = curl_copy_handle($ch);
    curl_setopt($rch, CURLOPT_URL, $url);
    curl_setopt($rch, CURLOPT_FOLLOWLOCATION, false);
    curl_setopt($rch, CURLOPT_HEADER, true);
    curl_setopt($rch, CURLOPT_NOBODY, true);
    curl_setopt($rch, CURLOPT_FORBID_REUSE, false);
    curl_setopt($rch, CURLOPT_RETURNTRANSFER, true);

    // follow up to $mr redirects
    do {
      $header = curl_exec($rch);
      if (curl_errno($rch)) {
        $code = 0;
      } else {
        $code = curl_getinfo($rch, CURLINFO_HTTP_CODE);
        if ($code == 301 || $code == 302) {
          preg_match('/Location:(.*?)\n/', $header, $matches);
          $newurl = trim(array_pop($matches));
        } else {
          $code = 0;
        }
      }
    } while ($code && --$mr);

    curl_close($rch);
    curl_setopt($ch, CURLOPT_URL, isset($newurl) ? $newurl : $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 5);
    curl_setopt($ch, CURLOPT_TIMEOUT, 10);
    curl_setopt($ch, CURLOPT_BINARYTRANSFER, TRUE);
    curl_setopt($ch, CURLOPT_HEADER, 0);
    // curl_setopt($ch, CURLOPT_USERAGENT, 'gt_footerdaemon / ' . $this->GT_FOOTERDAEMON_VERSION . ' / ' . $_SERVER['HTTP_HOST']);

    return $ch;
  }
}
