<?php

namespace Drupal\hg_reader\Entity;

use Drupal\Core\Entity\EntityStorageInterface;
use Drupal\Core\Field\BaseFieldDefinition;
use Drupal\Core\Entity\ContentEntityBase;
use Drupal\Core\Entity\EntityTypeInterface;
use Drupal\Core\Entity\EntityChangedTrait;
use Drupal\hg_reader\HgImporterInterface;
use Drupal\user\UserInterface;
use \Drupal\node\Entity\Node;
use \Drupal\file\Entity\File;
use \Drupal\taxonomy\Entity\Term;
use Drupal\Core\Database\Connection;
use Drupal\Core\Messenger\MessengerTrait;
use Drupal\Core\File\FileSystemInterface;
use Drupal\Core\Datetime\DrupalDateTime;
use \Drupal\datetime\Plugin\Field\FieldType\DateTimeItemInterface;
use Drupal\Core\Datetime\DateFormatInterface;

/**
 * Defines the HgImporter entity. Each importer has a name, an ID or IDs
 * corresponding to a Mercury feed or feeds, a frequency, and a record of the
 * last time it was run.
 *
 * @ingroup hg_reader
 *
 * @ContentEntityType(
 *   id = "hg_reader_importer",
 *   label = @Translation("HgImporter entity"),
 *   handlers = {
 *     "view_builder" = "Drupal\Core\Entity\EntityViewBuilder",
 *     "list_builder" = "Drupal\hg_reader\Entity\Controller\HgImporterListBuilder",
 *     "views_data" = "Drupal\views\EntityViewsData",
 *     "form" = {
 *       "add" = "Drupal\hg_reader\Form\HgImporterForm",
 *       "edit" = "Drupal\hg_reader\Form\HgImporterForm",
 *       "delete" = "Drupal\hg_reader\Form\HgImporterDeleteForm",
 *       "delete_nodes" = "Drupal\hg_reader\Form\HgImporterDeleteNodesForm",
 *     },
 *     "access" = "Drupal\hg_reader\HgImporterAccessControlHandler",
 *   },
 *   base_table = "hg_importer",
 *   admin_permission = "administer hg importer entity",
 *   fieldable = TRUE,
 *   entity_keys = {
 *     "id" = "id",
 *     "label" = "name",
 *     "uuid" = "uuid"
 *   },
 *   links = {
 *     "canonical" = "/admin/structure/hg_reader_importer/{hg_reader_importer}",
 *     "edit-form" = "/admin/structure/hg_reader_importer/{hg_reader_importer}/edit",
 *     "delete-form" = "/admin/structure/hg_reader_importer/{hg_reader_importer}/delete",
 *     "process-importer" = "/admin/structure/hg_reader_importer/{hg_reader_importer}/process-importer",
 *     "delete-nodes-form" = "/admin/structure/hg_reader_importer/{hg_reader_importer}/delete-nodes",
 *     "collection" = "/admin/structure/hg_reader_importer/list"
 *   },
 *   field_ui_base_route = "entity.hg_reader_importer.settings",
 * )
 *
 */
class HgImporter extends ContentEntityBase implements HgImporterInterface {

  use EntityChangedTrait; // Implements methods defined by EntityChangedInterface.
  use MessengerTrait;

  /**
   * {@inheritdoc}
   *
   */
  public static function preCreate(EntityStorageInterface $storage_controller, array &$values) {
    parent::preCreate($storage_controller, $values);
    $values += array(
      'user_id' => \Drupal::currentUser()->id(),
    );
  }

  /**
   * {@inheritdoc}
   */
  public function getCreatedTime() {
    return $this->get('created')->value;
  }

  /**
   * {@inheritdoc}
   */
  public function getOwner() {
    return $this->get('user_id')->entity;
  }

  /**
   * {@inheritdoc}
   */
  public function getOwnerId() {
    return $this->get('user_id')->target_id;
  }

  /**
   * {@inheritdoc}
   */
  public function setOwnerId($uid) {
    $this->set('user_id', $uid);
    return $this;
  }

  /**
   * {@inheritdoc}
   */
  public function setOwner(UserInterface $account) {
    $this->set('user_id', $account->id());
    return $this;
  }

  /**
   * Get all the IDs listed in all importers.
   * @return array An array of feed IDs
   */
  function get_all_fids() {
    $importers = \Drupal::entityTypeManager()->getStorage('hg_reader_importer')->loadMultiple();
    foreach ($importers as $key => $importer) {
      $fid = $importer->get('fid')->getValue();
      $fids[$key] = $fid[0]['value'];
    }
    return $fids;
  }

  /**
   * Get all the nids associated with a given importer.
   * @return array An array of nids
   */
  function get_mercury_nids() {
    $query = \Drupal::database()->select('node__field_hg_importer', 'i');
    $query->join('node__field_hg_id', 'm', 'i.entity_id = m.entity_id');
    $query->join('node', 'n', 'i.entity_id = n.nid');
    $query->fields('m', array('field_hg_id_value'));
    $query->fields('n', array('nid'));
    $query->condition('i.field_hg_importer_value', $this->get('id')->first()->getValue());
    $result = $query->execute();
    return $result->fetchAllKeyed();  }

  /**
   * Get all the importers.
   * @return array An array of importer objects
   */
  public static function get_all_importers() {
    // Two ways to skin a cat, apparently.
    return self::loadMultiple(\Drupal::entityQuery('hg_reader_importer')
      ->execute());
  }

  /**
   * Check the remote node list so that we have a reference for what does and
   * doesn't need to be created.
   * @param  integer  $id Feed ID
   * @return boolean  TRUE if
   */
  function audit_remote($id) {
    // Get the Mercury URL
    // TODO: Perhaps this should be done at instantiation and made a property of
    // the importer. Perhaps.
    $config = \Drupal::config('hg_reader.settings');
    $hg_url = $config->get('hg_url');

    // Get the feed receipt
    $url = $hg_url . '/ajax/hg/' . $id . '/list';
    $ch = $this->curl_setup($url);
    $data['data'] = curl_exec($ch);
    $data['info'] = curl_getinfo($ch);
    $data['err'] = curl_error($ch);

    if (!$this->process_errors($id, 'feed', $data)) {
      curl_close($ch);
      // TODO: This needs to be checked to see whether it actually works. Also
      // the process_errors function needs to handle malformed URLs.
      return false;
    }

    // Check whether any of the nodes on the receipt do not yet exist.
    $remote_nodes = json_decode($data['data']);
    $this->preexisting = $this->intersect_remote_with_local($remote_nodes);

    // Save the node list and go.
    if (count($this->preexisting) == count($remote_nodes)) { return false; }
    return true;
  }

  function intersect_remote_with_local($remote_nodes) {
    $preexisting = array();
    foreach ($remote_nodes as $remote_node) {
      $query = \Drupal::database()->select('node', 'n');
      $query->join('node__field_hg_id', 'mi', 'n.nid = mi.entity_id');
      $query->condition('mi.field_hg_id_value', $remote_node);
      $query->addExpression('COUNT(*)');
      $count = $query->execute()->fetchField();
      //  if nodes all exist, return false
      if ($count == 1) { $preexisting[] = $remote_node; }
    }
    return $preexisting;
  }

  /**
   * Get the full list of nodes that have been deleted
   * @return array An array of node ids
   */
  function get_deleted() {
    $config = \Drupal::config('hg_reader.settings');
    $hg_url = $config->get('hg_url');

    $url = $hg_url . '/deltracker/json';
    $ch = $this->curl_setup($url);
    $data['data'] = curl_exec($ch);
    $data['info'] = curl_getinfo($ch);
    $data['err'] = curl_error($ch);

    // Needs a different error checking routine than the usual curl process.
    curl_close($ch);

    return json_decode($data['data'], TRUE);
  }

  /**
   * [delete_tracked description]
   * @param  [type] $importer [description]
   * @param  [type] $deleted  [description]
   * @return [type]           [description]
   */
  function delete_tracked($importer, $deleted) {
    // Don't process importers marked do not track.
    if (!$importer->get('track_deletes')->getString()) { return; }

    // Get all the nids associated with this importer.
    $mercury_ids = $importer->get_mercury_nids();

    // Find the intersection between all_nids and deleted, keyed by id with type
    // as the value.
    $to_delete = array_intersect_key($mercury_ids, $deleted);
    if (!is_array($to_delete) || count($to_delete) < 1) { return; }

    // DESTROY! DESTROY!
    $storage_handler = \Drupal::EntityTypeManager()->getStorage('node');
    $entities = $storage_handler->loadMultiple($to_delete);
    $storage_handler->delete($entities);

    // Message in a bottle.
    if (!empty($to_delete)) {
      \Drupal::logger('hg_reader')->info(t('@count nodes deleted from importer "@importer".', array('@count' => count($to_delete), '@importer' => $importer->get('name')->first()->getValue()['value'])));
    }
  }

  /**
   * The heart of hg_reader. Given the ID of the item to pull, this does
   * the pulling.
   * @param  integer $id     Mercury ID of item
   * @param  string $type    Type of item, either feed, item, file, or image
   * @param  string $option  Used for image presets
   * @return array           XML from Mercury
   */
  function pull_remote($id, $type = 'feed', $option = NULL) {
    // TODO: This stuff might need to be sanitized; definitely need some error
    // checking.

    // Get the Mercury URL
    $config = \Drupal::config('hg_reader.settings');
    $hg_url = $config->get('hg_url');

    // What type of data are we getting?
    switch ($type) {
      case 'feed':
      case 'item':
        $url = $hg_url . '/xml/' . $id;
        break;
      case 'file':
        $url = $hg_url . '/hgfile/' . $id;
        break;
      case 'image':
        $url = $hg_url . '/hgimage/' . $id . '/' . $option;
        break;
    }

    // Get it.
    $ch = $this->curl_setup($url);
    $data['data'] = curl_exec($ch);
    $data['info'] = curl_getinfo($ch);
    $data['err'] = curl_error($ch);

    // Check for errahs.
    if (!$this->process_errors($id, $type, $data)) {
      curl_close($ch);
      return false;
    }

    // Sweet success
    curl_close($ch);
    return $data;
  }

  /**
   * Pull a list of updates to a feed since a given time.
   * @param  [type] $id       [description]
   * @param  [type] $last_run [description]
   * @return [type]           [description]
   */
  function pull_updates($last_run) {
    $config = \Drupal::config('hg_reader.settings');
    $hg_url = $config->get('hg_url');
    // $last_run = 1509680407; // for testing
    $url = $hg_url . '/uptracker/json/' . $last_run;

    $ch = $this->curl_setup($url);
    $data['data'] = curl_exec($ch);
    $data['info'] = curl_getinfo($ch);
    $data['err'] = curl_error($ch);

    // Needs a different error checking routine than the usual curl process.
    curl_close($ch);

    $remote_nodes = json_decode($data['data']);
    $this->preexisting = $this->intersect_remote_with_local($remote_nodes);

    return $this->preexisting;
  }

  /**
   * Generic cURL setup
   * @param  string   $url Duh
   * @return handle   A cURL handle of course
   */
  public static function curl_setup($url, $follow = TRUE) {
    $ch = curl_init();

    if ($follow) {
      /*
      * see: http://www.php.net/manual/en/function.curl-setopt.php#102121
      */
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
    }
    curl_setopt($ch, CURLOPT_URL, isset($newurl) ? $newurl : $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, false);
    curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 5);
    // curl_setopt($ch, CURLOPT_TIMEOUT, variable_get('hg_curl_timeout', 10));
    curl_setopt($ch, CURLOPT_TIMEOUT, 10);
    curl_setopt($ch, CURLOPT_BINARYTRANSFER, TRUE);
    curl_setopt($ch, CURLOPT_HEADER, 0);
    curl_setopt($ch, CURLOPT_USERAGENT, 'hg_reader / drupal / ' . READER_VERSION . ' / ' . $_SERVER['HTTP_HOST']);

    return $ch;
  }

  /**
   * Handle the myriad possible HTTP errors that can occur, generating error
   * messages as needed.
   * @param  int    $id   The item id
   * @param  string $type The item type
   * @param  array  $data Shit returned by cURL. Contains the HTTP code.
   * @return bool         True if there's nothing nasty, false otherwise.
   */
  function process_errors($id, $type, $data) {
    if ($data['info']['http_code'] == 404) {
      if ($type == 'feed') {
        $this->readerSetMessage('Mercury error: The ' . $type . ' (' . $id . ') was not found.', 'warning');
        return false;
      } else { return '404'; }
    } else if ($data['info']['http_code'] == 403) {
      if ($type == 'item' || $type == 'feed') { $this->readerSetMessage('Mercury error: Access to the ' . $type . ' (' . $id . ') is restricted.', 'warning'); }
      return false;
    } else if ($data['info']['http_code'] == 307) {
      if ($type == 'item' || $type == 'feed') { $this->readerSetMessage('Mercury error: This ' . $type . ' (' . $id . ') is unpublished.', 'warning'); }
      return false;
    } else if ($data['info']['http_code'] == 503) {
      if ($type == 'item' || $type == 'feed') { $this->readerSetMessage('Mercury error: Mercury is offline.', 'warning'); }
      return false;
    } else if (strpos($data['err'], 'Operation timed out') > -1) {
      if ($type == 'item' || $type == 'feed') { $this->readerSetMessage('Mercury error: ' . $data['err'] . '. You may want to consider increasing the Mercury Reader\'s <a href="/admin/config/hg/hg-reader?destination=' . $_GET['q'] . '">curl timeout value</a>.', 'warning'); }
      return false;
    } else if ($data['err']) {
      if ($type == 'item' || $type == 'feed') { $this->readerSetMessage('Mercury error: ' . $data['err'] . '.', 'warning'); }
      return false;
    } else if (!$data['data']) {
      // No XML received. Set an error and return false.
      if ($type == 'item' || $type == 'feed') { $this->readerSetMessage('Mercury error: Mercury is not responding for an unknown reason.', 'warning'); }
      return false;
    }
    return true;
  }

  /**
   * [serialize_xml description]
   * @param  [type] $xml [description]
   * @return [type]      [description]
   */
  function serialize_xml($xml, $type = 'Feed') {
    $xslt = drupal_get_path('module', 'hg_reader') . '/xsl/hgSerialized' . $type . '.xsl';

    // load XML into DOMDocument
    $xmlDoc = new \DOMDocument();
    $xmlDoc->loadXML($xml['data']);

    // load XSL into DOMDocument
    $xslDoc = new \DomDocument();
    $xslDoc->load($xslt);

    // // mix 'em together
    $proc = new \XSLTProcessor();
    $proc->registerPHPFunctions();
    $proc->importStylesheet($xslDoc);
    return $proc->transformToXML($xmlDoc);
  }

  /**
   * [decode description]
   * @param  [type] $item [description]
   * @return [type]       [description]
   */
  function decode(&$item) {
    if (is_array($item)) {
      if (array_key_exists('format', $item) && array_key_exists('value', $item)) {
        if ($item['format'] == 'base64') {
          $item = base64_decode($item['value']);
        } else {
          $item = $item['value'];
        }
      } else {
        foreach ($item as &$subitem) {
          $this->decode($subitem);
        }
      }
    }
  }

  function get_text_format() {
    $config = \Drupal::config('hg_reader.settings');
    $formats = \Drupal::entityQuery('filter_format')->execute();
    // TODO: module should suggest creating a text format on installation
    $format = $config->get('hg_text_format');
    if (empty($format) || !in_array($format, $formats)) {
      if (in_array('restricted_html', $formats)) {
        $format = 'restricted_html';
      } elseif (in_array('limited_html', $formats)) {
        $format = 'limited_html';
      } elseif (in_array('basic_html', $formats)) {
        $format = 'basic_html';
      } else {
        $format = 'plain_text';
      }
    }
    return $format;
  }

  /**
   * [createNode description]
   * @param  [type] $rawnode [description]
   * @param  [type] $fid     [description]
   * @return [type]          [description]
   */
  function create_node($rawnode, $iid) {
    // Skip this node if it already exists.
    if (in_array($rawnode['nid'], $this->preexisting)) { return false; }

    // Create file object from remote URL.
    // $data = file_get_contents('https://www.drupal.org/files/druplicon.small_.png');
    // $file = file_save_data($data, 'public://druplicon.png', FILE_EXISTS_REPLACE);

    /**
     * TODO: Ok, this is a stopgap. Ideally all of these keys should be stored
     * in separate documents, preferably one document for each content type.
     * But, no time for that shit right now, so this instead...
     */

    $format = $this->get_text_format();

    // Before we get started, let's correct a dumb old mistake from a million years ago.
    if ($rawnode['type'] == 'hgTechInTheNews') { $rawnode['type'] = 'external_news'; }

    $parameters = $this->assemble_node($rawnode, $iid, $format);

    // Create node object
    $node = Node::create($parameters);
    $node->setOwnerId($this->getOwnerId());
    $node->save();

    return true;
  }

  /**
   * [assemble_node description]
   * @param  [type] $rawnode [description]
   * @param  [type] $iid     [description]
   * @param  [type] $format  [description]
   * @return [type]          [description]
   */
  function assemble_node($rawnode, $iid, $format) {
    // First we build the universal parts of each node.
    $parameters = array(
      'type'                    => 'hg_' . $rawnode['type'],
      'title'                   => $rawnode['title'] ?: 'No Title',
      'field_hg_importer'       => $iid,
      'field_hg_id'             => $rawnode['nid'],
      'body'                    => [
        'value' => $rawnode['body'],
        'format' => $format,
      ],
      'field_hg_source_updated' => $rawnode['changed'],
    );

    // Then we build the CT-specific parts of each node.
    switch($rawnode['type']) {
      case 'external_news':
        $parameters['field_hg_article_url']      = $rawnode['article_url'];
        $parameters['field_hg_dateline']         = substr($rawnode['article_dateline'], 0, 10);
        $parameters['field_hg_publication']      = $rawnode['publication'];
        $parameters['field_hg_related_files']    = $rawnode['files'];
        break;

      case 'event':
        $parameters['field_hg_extras']           = $rawnode['event_extras'];
        $parameters['field_hg_fee']              = $rawnode['event_fee'];
        $parameters['field_hg_location']         = $rawnode['event_location'];
        $parameters['field_hg_location_email']   = $rawnode['event_email'];
        $parameters['field_hg_location_phone']   = $rawnode['phone'];
        $parameters['field_hg_location_url']     = strpos($rawnode['event_url'], 'http') != 0 ? 'http://' . $rawnode['event_url'] : $rawnode['event_url'];
        $parameters['field_hg_related_files']    = $rawnode['files'];
        $parameters['field_hg_summary_sentence'] = $rawnode['sentence'];
        $parameters['field_hg_keywords']         = $this->process_terms($rawnode['keywords'], 'hg_keywords') ?: array();
        $parameters['field_hg_event_categories'] = $this->process_terms($rawnode['categories'], 'hg_categories') ?: array();
        $parameters['field_hg_invited_audience'] = $this->process_terms($rawnode['event_audience'], 'hg_invited_audience') ?: array();
        $parameters['field_hg_images']           = $this->process_images($rawnode['hg_media']) ?: array();
        // TODO: This is not in the serialized array but should be.
        // $parameters['field_hg_sidebar']          = $rawnode['sidebar'];
        $parameters['field_hg_contact']          = [
          'value' => $rawnode['contact'],
          'format' => $format,
        ];

        // Converting dates from hg.gatech.edu to UTC for storage.
        //\Drupal::logger('hg_reader')->notice("Raw start date [" . $rawnode['start'] . "].");
        $parameters['field_hg_event_time'] = $this->process_eventdate($rawnode['start'], $rawnode['end'], null);

        $parameters['field_hg_summary']          = [
          'value' => $rawnode['summary'],
          'format' => $format,
        ];
        foreach ($rawnode['related_links'] as $link) {
          $parameters['field_hg_related_links'][]    = [
            'uri' => $link['url'],
            'title' => $link['title'],
          ];
        }
        break;

      case 'image':
          // Image files are not collected in XML; first collect them.
        $rawnode['images']['image'] = [
          'image_name' => $rawnode['image_name'],
          'image_path' => $rawnode['image_path'],
          'body' => $rawnode['body'],
        ];
        $parameters['field_hg_images'] = $this->process_images($rawnode['images']) ?: array();
          break;

      case 'video':
        $parameters['field_hg_youtube_id'] = $rawnode['youtube_id'];
        break;

      case 'news':
        $parameters['field_hg_dateline']            = substr($rawnode['dateline'], 0, 10);
        $parameters['field_hg_email']               = $rawnode['email'];
        $parameters['field_hg_location']            = $rawnode['location'];
        $parameters['field_hg_related_files']       = $rawnode['files'];
        //$parameters['field_hg_related_links']       = $rawnode['related_links'];
        $parameters['field_hg_subtitle']            = $rawnode['subtitle'];
        $parameters['field_hg_summary_sentence']    = $rawnode['sentence'];
        $parameters['field_hg_keywords']            = $this->process_terms($rawnode['keywords'], 'hg_keywords') ?: array();
        $parameters['field_hg_categories']          = $this->process_terms($rawnode['categories'], 'hg_categories') ?: array();
        if (isset($rawnode['news_room_topics'])) {
          $parameters['field_hg_news_room_topics']  = $this->process_terms($rawnode['news_room_topics'], 'hg_news_room_topics') ?: array();
        }
        // TODO: Fix this.
        // $parameters['field_hg_core_research_areas'] = $this->process_terms($rawnode['core_research_areas']) ?: array();
        $parameters['field_hg_images']              = $this->process_images($rawnode['hg_media']) ?: array();
        $parameters['field_hg_youtube_video']       = $this->process_videos($rawnode['hg_media']) ?: array();
        $parameters['field_hg_contact']             = [
          'value' => $rawnode['contact'],
          'format' => $format,
        ];
        $parameters['field_hg_summary']             = [
          'value' => $rawnode['summary'],
          'format' => $format,
        ];
        $parameters['field_hg_sidebar']             = [
          'value' => $rawnode['sidebar'],
          'format' => $format,
        ];
        foreach ($rawnode['related_links'] as $link) {
          $parameters['field_hg_related_links'][]     = [
            'uri' => $link['url'],
            'title' => $link['title'],
          ];

        }

        break;
    }
    return $parameters;
  }

  /**
   * [update_node description]
   * @param  [type] $nid [description]
   * @return [type]      [description]
   */
  function update_node($remote_nid) {
    // pull a specific node
    $data = $this->pull_remote($remote_nid, 'item');
    $remote_node = unserialize($this->serialize_xml($data, 'Item'));
    $this->decode($remote_node);

    // apply updates to local copy
    $nid = \Drupal::database()->select('node__field_hg_id', 'mid')
      ->fields('mid', array('entity_id'))
      ->condition('field_hg_id_value', $remote_nid)
      ->execute()
      ->fetchAssoc();
    $node = \Drupal::entityTypeManager()->getStorage('node')->load($nid['entity_id']);
    $this->modify_node($node, $remote_node);
    // dpm($node, 'node');
    $node->save();
  }

  /**
   * [modify_node description]
   * @param  [type] $node        [description]
   * @param  [type] $remote_node [description]
   * @return [type]              [description]
   */
  function modify_node(&$node, $remote_node) {
    $format = $this->get_text_format();

    // Universal bits
    $node->set('title', $remote_node['title'] ?: 'No Title');
    $node->set('body', [
      'value' => $remote_node['body'],
      'format' => $format,
    ]);

    switch($remote_node['type']) {
      case 'external_news':
        $node->set('field_hg_article_url', $remote_node['article_url']);
        $node->field_hg_dateline->set(0, [
          'value' => substr($remote_node['article_dateline'], 0, 10),
        ]);
        $node->set('field_hg_publication', $remote_node['publication']);
        $node->set('field_hg_related_files', $remote_node['files']);
        break;

      case 'event':
        $node->set('field_hg_extras', $remote_node['extras']);
        $node->set('field_hg_fee', $remote_node['fee']);
        $node->set('field_hg_location', $remote_node['location']);
        $node->set('field_hg_location_email', $remote_node['locationemail']);
        $node->set('field_hg_location_phone', $remote_node['locationphone']);
        $node->set('field_hg_location_url', strpos($remote_node['locationurl'], 'http') != 0 ? 'http://' . $remote_node['locationurl'] : $remote_node['locationurl']);
        $node->set('field_hg_related_files', $remote_node['files']);
        $node->set('field_hg_related_links', $remote_node['links']);
        $node->set('field_hg_summary_sentence', $remote_node['sentence']);
        // $node->set('field_hg_keywords']         = $this->process_terms($remote_node['keywords']) ?: array();
        // $node->set('field_hg_event_categories'] = $this->process_terms($remote_node['categories']) ?: array();
        $node->set('field_hg_invited_audience', $this->process_terms($remote_node['event_audience'], 'audience') ?: array());
        $images = $this->process_images($remote_node['media']);
        if (!empty($images)) {
          foreach ($images as $key => $image) {
            $node->field_hg_images->set($key, $this->process_images($remote_node['media']) ?: array());
          }
        }
        // TODO: This is not in the serialized array but should be.
        // $node->set('field_hg_sidebar']          = $remote_node['sidebar']);
        $node->field_hg_contact->set(0, [
          'value' => $remote_node['contact'],
          'format' => $format,
        ]);

        $processed_time = $this->process_eventdate($remote_node['times'][0]['startdate'], $remote_node['times'][0]['stopdate'], $remote_hg['times'][0]['timezone']);

        $node->field_hg_event_time->set(0, $processed_time);

        $node->field_hg_summary->set(0, [
          'value' => $remote_node['summary'],
          'format' => $format,
        ]);
        break;

      case 'image':
          // Image files are not collected in XML; first collect them.
        $remote_node['images']['image'] = [
          'image_name' => $remote_node['image_name'],
          'image_path' => $remote_node['image_path'],
          'body' => $remote_node['body'],
        ];
        $node->set('field_hg_images', $this->process_images($remote_node['images']) ?: array());
          break;

      case 'video':
        $node->set('field_hg_youtube_id', $remote_node['youtube_id']);
        break;

      case 'news':
        // $node->set('field_hg_dateline', substr($remote_node['dateline'], 0, 19));
        $node->field_hg_dateline->set(0, [
          'value' => substr($remote_node['dateline'], 0, 10),
        ]);
        $node->set('field_hg_email', $remote_node['contact_email']);
        $node->set('field_hg_location', $remote_node['location']);
        $node->set('field_hg_related_files', $remote_node['files']);
        $node->set('field_hg_related_links', $remote_node['links']);
        $node->set('field_hg_subtitle', $remote_node['subtitle']);
        $node->set('field_hg_summary_sentence', $remote_node['sentence']);
        // $node->set('field_hg_keywords']            = $this->process_terms($remote_node['keywords']) ?: array();
        // $node->set('field_hg_categories']          = $this->process_terms($remote_node['categories']) ?: array();
        // $node->set('field_hg_news_room_topics']    = $this->process_terms($remote_node['news_terms']) ?: array();
        // TODO: Fix this.
        // $node->set('field_hg_core_research_areas'] = $this->process_terms($remote_node['core_research_areas']) ?: array();
        $images = $this->process_images($remote_node['media']);
        if (!empty($images)) {
          foreach ($images as $key => $image) {
            $node->field_hg_images->set($key, $this->process_images($remote_node['media']) ?: array());
          }
        }
        $videos = $this->process_videos($remote_node['media']);
        if (!empty($videos)) {
          foreach ($videos as $key => $video) {
            $node->field_hg_youtube_video->set($key, $this->process_videos($remote_node['media']) ?: array());
          }
        }
        $node->field_hg_contact->set(0, [
          'value' => $remote_node['contact'],
          'format' => $format,
        ]);
        $node->field_hg_summary->set(0, [
          'value' => $remote_node['summary'],
          'format' => $format,
        ]);
        $node->field_hg_sidebar->set(0, [
          'value' => $remote_node['sidebar'],
          'format' => $format,
        ]);

        break;
    }
  }

  /**
   * [process_images description]
   * @return [type] [description]
   */
  function process_images($images) {
    $config = \Drupal::config('hg_reader.settings');
    $hg_url = $config->get('hg_url');

    // TODO: Image path should be part of the module's configuration.
    $image_path = 'public://hg_media';
    if (\Drupal::service('file_system')->prepareDirectory($image_path, FileSystemInterface::CREATE_DIRECTORY)) {
      $image_list = array();

      foreach ($images as $image) {
        if (!empty($image['youtube_id'])) {
          continue;
        } else if (!$data = @file_get_contents($image['image_path'])) { continue; }
        $file = file_save_data($data, 'public://' . 'hg_media/' . $image['image_name'], FileSystemInterface::EXISTS_REPLACE);
        $image_list[$file->id()] = [
          'target_id' => $file->id(),
          'alt' => substr(strip_tags($image['body']), 0, 512),
          'title' => substr(strip_tags($image['body']), 0, 512),
        ];
      }
      return $image_list;

    } else {
      // TODO: Oh Lord
      \Drupal::messenger()->addMessage(t('Media destination directory is faulty.'), 'error');
      return FALSE;
    }
  }

  /**
   * [process_videos description]
   * @return [type] [description]
   */
  function process_videos($videos) {
    $video_list = array();

    foreach ($videos as $video) {
      if (empty($video['youtube_id'])) {
        continue;
      } else {
        $video_list[] = 'http://youtu.be/' . $video['youtube_id'];
      }
    }
    return $video_list;
  }


  /**
   * [process_terms description]
   * @param  [type] $keywords [description]
   * @return [type]           [description]
   */
  function process_terms($rawterms, $fieldname = NULL) {
    if (empty($rawterms)) { return FALSE; }
    $tids = array();
    foreach ($rawterms as $rawterm) {
      if (is_array($rawterm)) { $rawterm = $rawterm[$fieldname]; }
      $terms = taxonomy_term_load_multiple_by_name($rawterm, $fieldname);
      if ($terms == NULL) {
        $created = $this->create_term($rawterm, $fieldname);
        if ($created) {
          $new_terms = taxonomy_term_load_multiple_by_name($rawterm, $fieldname);
          foreach ($new_terms as $key => $term) {
            $tids[] = $key;
          }
        }
      } else {
        foreach ($terms as $key => $term) {
          $tids[] = $key;
        }
      }
    }
    return $tids;
  }

  /**
   * [_create_term description]
   * @param  [type] $name          [description]
   * @param  [type] $taxonomy_type [description]
   * @return [type]                [description]
   */
  function create_term($name, $taxonomy_type) {
    $term = Term::create([
      'name' => $name,
      'vid' => $taxonomy_type,
    ])->save();
    return TRUE;
  }

  /**
   * [readerSetMessage description]
   * @param [type] $message  [description]
   * @param [type] $severity [description]
   */
  function readerSetMessage($message, $severity) {
    switch ($severity) {
      case 'error':
        if (error_displayable()) { \Drupal::messenger()->addMessage(t($message), $severity); }
        else { \Drupal::logger('hg_reader')->{$severity}($message); }
        break;
      case 'warning':
        if (error_displayable()) { \Drupal::messenger()->addMessage(t($message), $severity); }
        else { \Drupal::logger('hg_reader')->{$severity}($message); }
        break;
    }
  }

  /**
   * Delete all the nodes associated with the given importer.
   * @param  [type] $iid [description]
   * @return [type]      [description]
   */
  function delete_nodes($iid) {
    $name = $this->get('name')->first()->getValue();
    $result = \Drupal::entityQuery('node')
        ->condition('field_hg_importer', $iid)
        ->execute();

    $storage_handler = \Drupal::entityTypeManager()->getStorage('node');
    $entities = $storage_handler->loadMultiple($result);
    $storage_handler->delete($entities);

    \Drupal::messenger()->addMessage(t('Deleted all content from <em>@name</em>.', array('@name' => $name['value'])), 'status');
  }

  /**
   * Return count of items associated with this importer.
   *
   */
  function countItems($iid) {
    $query = \Drupal::entityQuery('node')
      ->condition('field_hg_importer', $iid);
    $count = $query->count()->execute();
    return $count;
  }

  /**
   * {@inheritdoc}
   *
   */
  public static function baseFieldDefinitions(EntityTypeInterface $entity_type) {

    $fields['id'] = BaseFieldDefinition::create('integer')
      ->setLabel(t('ID'))
      ->setDescription(t('The ID of the importer.'))
      ->setReadOnly(TRUE);

    // Standard field, unique outside of the scope of the current project.
    $fields['uuid'] = BaseFieldDefinition::create('uuid')
      ->setLabel(t('UUID'))
      ->setDescription(t('The UUID of the importer.'))
      ->setReadOnly(TRUE);

    $fields['name'] = BaseFieldDefinition::create('string')
      ->setLabel(t('Name'))
      ->setDescription(t('The name of the importer.'))
      ->setRequired(TRUE)
      ->setSettings(array(
        'default_value' => '',
        'max_length' => 255,
        'text_processing' => 0,
      ))
      ->setDisplayOptions('view', array(
        'label' => 'above',
        'type' => 'string',
        'weight' => -6,
      ))
      ->setDisplayOptions('form', array(
        'type' => 'string_textfield',
        'weight' => -6,
      ))
      ->setDisplayConfigurable('form', TRUE)
      ->setDisplayConfigurable('view', TRUE);

    $fields['fid'] = BaseFieldDefinition::create('integer')
      ->setLabel(t('Feed ID'))
      ->setDescription(t('The ID of the feed you wish to pull from Mercury. You may enter multiple IDs.'))
      ->setRequired(TRUE)
      ->setCardinality(-1)
      ->setDisplayOptions('view', array(
        'label' => 'above',
        'type' => 'number',
        'weight' => -7,
      ))
      ->setDisplayOptions('form', array(
        'type' => 'number',
        'settings' => [
          'placeholder' => '000000'
        ],
        'weight' => -4,
      ))
      ->setDisplayConfigurable('form', TRUE)
      ->setDisplayConfigurable('view', TRUE);

    $fields['frequency'] = BaseFieldDefinition::create('integer')
      ->setLabel(t('Import frequency'))
      ->setDescription(t('The frequency, in minutes, that the feed will be updated. Please do not set this lower than 60 unless you are testing something. Remember that you can always pull feeds manually if you push something out quickly.'))
      ->setRequired(TRUE)
      ->setCardinality(1)
      ->setDefaultValue(60)
      ->setDisplayOptions('view', array(
        'label' => 'above',
        'type' => 'number',
        'weight' => -7,
      ))
      ->setDisplayOptions('form', array(
        'type' => 'number',
        'settings' => [
          'placeholder' => '60'
        ],
        'weight' => -3,
      ))
      ->setDisplayConfigurable('form', TRUE)
      ->setDisplayConfigurable('view', TRUE);

    $fields['track_deletes'] = BaseFieldDefinition::create('boolean')
      ->setLabel(t('Track deletions'))
      ->setDescription(t('Delete local nodes when corresponding nodes are deleted from Mercury. (This is an experimental feature and should be used with caution.)'))
      ->setDefaultValue(FALSE)
      ->setDisplayOptions('form', array(
        'weight' => -2,
      ))
      ->setDisplayConfigurable('form', TRUE)
      ->setDisplayConfigurable('view', TRUE);

    $fields['last_run'] = BaseFieldDefinition::create('integer')
      ->setLabel(t('Last pull'))
      ->setDescription(t('Timestamp of last import.'))
      ->setDefaultValue(0)
      ->setReadOnly(TRUE);

    $fields['user_id'] = BaseFieldDefinition::create('entity_reference')
      ->setLabel(t('Author'))
      ->setDescription(t('The author to be associated with all imported nodes.'))
      ->setRequired(TRUE)
      ->setSetting('target_type', 'user')
      ->setSetting('handler', 'default')
      ->setDisplayOptions('form', array(
        'type' => 'entity_reference_autocomplete',
        'settings' => array(
          'match_operator' => 'CONTAINS',
          'size' => 60,
          'placeholder' => '',
        ),
        'weight' => -5,
      ))
      ->setDisplayOptions('view', array(
        'label' => 'above',
        'type' => 'entity_reference_label',
        'weight' => -3,
      ))
      ->setDisplayConfigurable('form', TRUE)
      ->setDisplayConfigurable('view', TRUE);

    $fields['langcode'] = BaseFieldDefinition::create('language')
      ->setLabel(t('Language code'))
      ->setDescription(t('The language code of HgImporter entity.'));

    $fields['created'] = BaseFieldDefinition::create('created')
      ->setLabel(t('Created'))
      ->setDescription(t('The time that the entity was created.'));

    $fields['changed'] = BaseFieldDefinition::create('changed')
      ->setLabel(t('Changed'))
      ->setDescription(t('The time that the entity was last edited.'));

    return $fields;
  }

  public function process_eventdate($raw_start, $raw_end, $timezone){
    // Timezone check via $raw_start
    $raw_start_tz = (new \DateTime($raw_start))->getTimezone()->getName();

    // Process the $timezone argument permutations, first, is timezone either invalid or not filled?
    if(empty($timezone) || (empty(in_array($timezone, timezone_identifiers_list())))){

      // If so, check to see if the $raw_start has a timezone in it
      if (!empty($raw_start_tz)){
        //\Drupal::logger('hg_reader')->notice("Timezone explicitly defined '" . $raw_start_tz . ".");
        // $raw_start has a timezone in it, so create explicit timezone based on that.
        $timezone = new \DateTimeZone($raw_start_tz);
      }

      // If not, make big assumption.
      else {
        //\Drupal::logger('hg_reader')->notice("No raw timezone found, assuming 'America/New_York'.");
        // Individual item feeds do not have a timezone, just a timestamp sans timezone, so casing for that.
        // Assume time zone in XML is 'America/New York' from hg.gatech
        $timezone = new \DateTimeZone('America/New_York');
      }
    }
    // $timezone argument provided, so we use it and trust the developer.
    else {
      //\Drupal::logger('hg_reader')->notice("Timezone found, " . $timezone . ".");
    }

    // Creating DrupalDateTime objects using timezone and date.
    $start = new DrupalDateTime($raw_start, $timezone);
    $end = new DrupalDateTime($raw_end, $timezone);

    // Converting dates from hg.gatech.edu to UTC for storage.
    $start->setTimeZone(new \DateTimeZone(DateTimeItemInterface::STORAGE_TIMEZONE));
    $end->setTimeZone(new \DateTimeZone(DateTimeItemInterface::STORAGE_TIMEZONE));

    // Converting format to Drupal preferred storage string.
    $start->format(DateTimeItemInterface::DATETIME_STORAGE_FORMAT);
    $end->format(DateTimeItemInterface::DATETIME_STORAGE_FORMAT);

    // Returning the array for storage with start/end.
    return [
      'value' => date('Y-m-d\TH:i:s', strtotime($start->format('Y-m-d H:i:s'))),
      'end_value' => date('Y-m-d\TH:i:s', strtotime($end->format('Y-m-d H:i:s'))),
    ];
  }
}
