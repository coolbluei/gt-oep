<?php

namespace Drupal\hg_reader\Entity;

use Drupal\Core\Database\Connection;
use Drupal\Core\Datetime\DateFormatInterface;
use Drupal\Core\Datetime\DrupalDateTime;
use Drupal\Core\Entity\ContentEntityBase;
use Drupal\Core\Entity\EntityChangedTrait;
use Drupal\Core\Entity\EntityStorageInterface;
use Drupal\Core\Entity\EntityTypeInterface;
use Drupal\Core\Field\BaseFieldDefinition;
use Drupal\Core\Field\FieldItemList;
use Drupal\Core\File\FileSystemInterface;
use Drupal\Core\Messenger\MessengerTrait;
use Drupal\datetime\Plugin\Field\FieldType\DateTimeItemInterface;
use Drupal\file\Entity\File;
use Drupal\file\FileRepositoryInterface;
use Drupal\hg_reader\HgImporterInterface;
use Drupal\media\Entity\Media;
use Drupal\node\Entity\Node;
use Drupal\taxonomy\Entity\Term;
use Drupal\user\UserInterface;

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
      ->accessCheck(FALSE)
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

  /**
   * Check the remote node list against local nodes so we don't import duplicates.
   * @param  array $remote_nodes A list of nodes on Mercury
   * @return array $preexisting A list of nodes already imported
   */
  function intersect_remote_with_local($remote_nodes) {
    $preexisting = array();
    foreach ($remote_nodes as $remote_node) {
      $query = \Drupal::database()->select('node', 'n');
      $query->join('node__field_hg_id', 'mi', 'n.nid = mi.entity_id');
      $query->condition('mi.field_hg_id_value', $remote_node);
      $query->addExpression('COUNT(*)');
      $count = $query->execute()->fetchField();
      //  if nodes all exist, return false
      if ($count > 0) { $preexisting[] = $remote_node; }
    }
    return $preexisting;
  }

  /**
   * Get the full list of nodes that have been deleted from Mercury
   * @return array An array of node ids
   *
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
   * Delete nodes that have been deleted in Mercury. In practice this tends to
   * wipe out whole swaths of content inappropriately, so it's shelved for the
   * time being.
   * @param  HgImporter $importer One of these, duh
   * @param  Array $deleted       The full list of all nodes deleted from Mercury
   *                              in the last something, I don't remember what
   *                              period of time but it's longish.
   *
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
   *
   * @param  int $last_run  Time stamp for the last time the importer imported.
   * @return array          Array containting an intersection of nodes in the feed & nodes in this system
   */
  function pull_updates($last_run) {
    $config = \Drupal::config('hg_reader.settings');
    $hg_url = $config->get('hg_url');
    // $last_run = 1656082304; // for testing
    // This is a suck-ass way of doing this because I always forget to comment
    // it back out when I'm done. Perhaps a debugging setting would be better.
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

    $config = \Drupal::config('hg_reader.settings');
    $curl_connect_timeout = $config->get('hg_curl_timeout');

    $options = [
      CURLOPT_URL => $url,
      CURLOPT_HEADER => false,
      CURLOPT_NOBODY => false,
      CURLOPT_FOLLOWLOCATION => true,
      CURLOPT_MAXREDIRS => 10,
      CURLOPT_AUTOREFERER => true,
      CURLOPT_FORBID_REUSE => false,
      CURLOPT_RETURNTRANSFER => true,
      CURLOPT_FAILONERROR => true,
      CURLOPT_CONNECTTIMEOUT => $curl_connect_timeout,
      CURLOPT_TIMEOUT => 60,
      CURLOPT_USERAGENT => 'hg_reader / drupal / ' . READER_VERSION . ' / ' . $_SERVER['HTTP_HOST'],
    ];

    curl_setopt_array($ch, $options);
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
   * Applies the appropriate XSLT stylesheet to the imported XML to produce a
   * serialized PHP array.
   * @param  String $xml  The imported XML
   * @param  String $type "Feed" or "Item"; Used to select the proper XSLT sheet.
   * @return String       An imported node rendered as a serialized PHP array.
   */
  function serialize_xml($xml, $type = 'Feed') {
    $xslt = \Drupal::service('extension.path.resolver')->getPath('module', 'hg_reader') . '/xsl/hgSerialized' . $type . '.xsl';

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
   * Converts all base64 fields in imported node array back to regular text.
   * @param  Array $item The unserialized node array
   *
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

  /**
   * Gets the selected text format from hg settings.
   * @return string       The selected format.
   */
  function get_text_format() {
    $config = \Drupal::config('hg_reader.settings');
    $formats = \Drupal::entityQuery('filter_format')
      ->accessCheck(FALSE)
      ->execute();
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
   * Creates a new node from Hg XML
   * @param  Array  $rawnode   An array of node elements parsed from Hg XML
   * @param  Int    $iid       Importer ID
   * @return Boolean           Returns TRUE no matter what, which is pretty stupid really.
   */
  function create_node($rawnode, $iid) {
    // Skip this node if it already exists.
    if (in_array($rawnode['nid'], $this->preexisting)) { return false; }

    /**
     * TODO: Ok, this is a stopgap. Ideally all of these keys should be stored
     * in separate documents, preferably one document for each content type.
     * But, no time for that shit right now, so this instead...
     */

    $format = $this->get_text_format();

    // Before we get started, let's correct a dumb old mistake from a million years ago.
    if ($rawnode['type'] == 'hgTechInTheNews') { $rawnode['type'] = 'external_news'; }

    $parameters = $this->create_node_helper($rawnode, $iid, $format);

    // Create node object
    $node = Node::create($parameters);
    $node->setOwnerId($this->getOwnerId());
    $node->save();

    return $node;
  }

  /**
   * Offloads the nitty gritty of node creation.
   * @param  Array $rawnode   An array of node elements parsed from Hg XML
   * @param  Int $iid         Importer ID
   * @param  String $format   The selected text format
   * @return Array            An array of node elements processed and ready for socking into a node.
   */
  function create_node_helper($rawnode, $iid, $format) {
    // First we build the universal parts of each node.
    $elements = array(
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
        $elements['field_hg_article_url']      = $rawnode['article_url'];
        $elements['field_hg_dateline']         = isset($rawnode['dateline']) ? substr($rawnode['dateline'], 0, 10) : '';
        $elements['field_hg_publication']      = $rawnode['publication'];
        $elements['field_hg_related_files']    = isset($rawnode['files']) ? $rawnode['files'] : '';
        break;

      case 'event':
        // Easy fields
        $elements['field_hg_fee']              = $rawnode['event_fee'];
        $elements['field_hg_location']         = $rawnode['event_location'];
        $elements['field_hg_location_email']   = $rawnode['event_email'];
        $elements['field_hg_location_phone']   = $rawnode['phone'];
        $elements['field_hg_location_url']     = strpos($rawnode['event_url'], 'http') != 0 ? 'http://' . $rawnode['event_url'] : $rawnode['event_url'];
        $elements['field_hg_related_files']    = $rawnode['files'];
        $elements['field_hg_summary_sentence'] = $rawnode['sentence'];
        $elements['field_hg_keywords']         = $this->process_terms($rawnode['keywords'], 'hg_keywords') ?: array();
        $elements['field_hg_event_categories'] = $this->process_terms($rawnode['categories'], 'hg_event_categories') ?: array();
        $elements['field_hg_invited_audience'] = $this->process_terms($rawnode['event_audience'], 'hg_invited_audience') ?: array();
        $elements['field_hg_images']           = $this->process_images($rawnode['hg_media']) ?: array();
        $elements['field_hg_event_time']       = $this->process_eventdate($rawnode['start'], $rawnode['end'], null);

        // Extras
        foreach ($rawnode['event_extras'] as $extra) {
          $elements['field_hg_extras'][] = $extra['extra'];
        }

        // Groups
        foreach ($rawnode['groups'] as $group) {
          $elements['field_hg_groups'][] = $group['name'];
        }

        // TODO: This is not in the serialized array but should be.
        // $elements['field_hg_sidebar']          = $rawnode['sidebar'];

        // Contact
        $elements['field_hg_contact']          = [
          'value' => $rawnode['contact'],
          'format' => $format,
        ];

        // Summary
        $elements['field_hg_summary']          = [
          'value' => $rawnode['summary'],
          'format' => $format,
        ];

        // Location URL
        $elements['field_hg_location_url'] = [
          'uri' => strpos($rawnode['event_url'], 'http') != 0 ? 'http://' . $rawnode['event_url'] : $rawnode['event_url'],
          'title' => $rawnode['event_url_title'],
        ];

        // Related links
        foreach ($rawnode['related_links'] as $link) {
          $elements['field_hg_related_links'][]    = [
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
        $elements['field_hg_images'] = $this->process_images($rawnode['images']) ?: array();
          break;

      case 'video':
        $elements['field_hg_youtube_id'] = $rawnode['youtube_id'];
        break;

      case 'profile':
        $elements['field_hg_alternate_job_title']           = $rawnode['alttitle'];
        $elements['field_hg_city']                          = $rawnode['city'];
        $elements['field_hg_college_school']                = $rawnode['college_school'];
        $elements['field_hg_department']                    = $rawnode['department'];
        $elements['field_hg_fax_number']                    = $rawnode['fax'];
        $elements['field_hg_first_name']                    = $rawnode['firstname'];
        $elements['field_hg_job_title']                     = $rawnode['jobtitle'];
        $elements['field_hg_last_name']                     = $rawnode['lastname'];
        $elements['field_hg_linkedin']                      = $rawnode['linkedin'];
        $elements['field_hg_middle_name']                   = $rawnode['middlename'];
        $elements['field_hg_mobile_phone']                  = $rawnode['cell'];
        $elements['field_hg_nickname']                      = $rawnode['nickname'];
        $elements['field_hg_phone_number']                  = $rawnode['phone'];
        $elements['field_hg_primary_email']                 = $rawnode['primaryemail'];
        $elements['field_hg_research']                      = $rawnode['research'];
        $elements['field_hg_secondary_email']               = $rawnode['secondaryemail'];
        $elements['field_hg_specialty']                     = $rawnode['specialty'];
        $elements['field_hg_state']                         = $rawnode['state'];
        $elements['field_hg_street_address']                = $rawnode['address'];
        $elements['field_hg_summary']                       = $rawnode['summary'];
        $elements['field_hg_teaching']                      = $rawnode['teaching'];
        $elements['field_hg_twitter']                       = $rawnode['twitter'];
        $elements['field_hg_zip_code']                      = $rawnode['zipcode'];

        $elements['field_hg_media']                            = $this->process_media($rawnode['hg_media']) ?: array();
        // $elements['field_hg_youtube_video']                 = $this->process_media($rawnode['hg_media'], 'remote_video') ?: array();

        $elements['field_hg_related_files']                 = $this->process_files($rawnode['files']) ?: array();

        if (isset($rawnode['areas_of_expertise'])) {
          $elements['field_hg_expertise'] = $this->process_terms($rawnode['areas_of_expertise'], 'hg_areas_of_expertise') ?: array();
        }

        foreach ($rawnode['classifications'] as $classification) {
          $classification = strtolower(preg_replace('/\s+/', '_', $classification));
          $elements['field_hg_classification'][] = $classification;
        }

        $degree = strtolower(preg_replace('/\s+/', '_', $rawnode['degree']));
        $elements['field_hg_degree'] = $degree;

        $elements['field_hg_url'][] = [
          'uri' => $rawnode['url'],
          'title' => $rawnode['url_title'],
        ];

        foreach ($rawnode['related_links'] as $link) {
          $elements['field_hg_related_links'][]     = [
            'uri' => $link['url'],
            'title' => $link['title'],
          ];
        }

        foreach ($rawnode['recent_news'] as $hg_id) {
          $query = \Drupal::entityQuery('node')
            ->accessCheck(TRUE)
            ->condition('field_hg_id', $hg_id);
            $referenced = $query->execute();

          // This item is in the system already
          if (!empty($referenced)) {
            $elements['field_hg_recent_appearances'][] = [
              'target_id' => reset($referenced)
            ];
          } else {
            // Item is not in the system. We need to import it and add it to the field.
            $new_node_xml = $this->pull_remote($hg_id, 'item');
            $new_node_raw = unserialize($this->serialize_xml($new_node_xml, 'Item'));
            $this->decode($new_node_raw);
            $new_node = $this->create_node($new_node_raw, $this->id());
            $elements['field_hg_recent_appearances'][] = $new_node->id();
          }
        }
        break;

      case 'news':
        $elements['field_hg_dateline']            = substr($rawnode['dateline'], 0, 10);
        $elements['field_hg_email']               = isset($rawnode['email']) ? $rawnode['email'] : '';
        $elements['field_hg_location']            = isset($rawnode['location']) ? $rawnode['location'] : '';
        $elements['field_hg_related_files']       = isset($rawnode['files']) ? $rawnode['files'] : '';
        $elements['field_hg_subtitle']            = isset($rawnode['subtitle']) ? $rawnode['subtitle'] : '';
        $elements['field_hg_summary_sentence']    = isset($rawnode['sentence']) ? $rawnode['sentence'] : '';
        $elements['field_hg_keywords']            = $this->process_terms($rawnode['keywords'], 'hg_keywords') ?: array();
        $elements['field_hg_categories']          = $this->process_terms($rawnode['categories'], 'hg_categories') ?: array();
        if (isset($rawnode['news_room_topics'])) {
          $elements['field_hg_news_room_topics']  = $this->process_terms($rawnode['news_room_topics'], 'hg_news_room_topics') ?: array();
        }
        if (isset($rawnode['core_research_areas'])) {
          $elements['field_hg_core_research_areas']  = $this->process_terms($rawnode['core_research_areas'], 'hg_core_research_areas') ?: array();
        }
        // TODO: Fix this.
        // $elements['field_hg_core_research_areas'] = $this->process_terms($rawnode['core_research_areas']) ?: array();
        $elements['field_hg_images']              = isset($rawnode['hg_media']) ? $this->process_images($rawnode['hg_media']) : array();
        $elements['field_hg_youtube_video']       = isset($rawnode['hg_media']) ? $this->process_videos($rawnode['hg_media']) : array();

        $elements['field_hg_contact']             = [
          'value' => $rawnode['contact'],
          'format' => $format,
        ];
        $elements['field_hg_summary']             = [
          'value' => $rawnode['summary'],
          'format' => $format,
        ];
        $elements['field_hg_sidebar']             = [
          'value' => $rawnode['sidebar'],
          'format' => $format,
        ];
        if (isset($rawnode['related_links']) && is_array($rawnode['related_links'])) {
          foreach ($rawnode['related_links'] as $link) {
            $elements['field_hg_related_links'][]     = [
              'uri' => $link['url'],
              'title' => $link['title'],
            ];
          }
        }

        break;
    }
    return $elements;
  }

  /**
   * Updates an existing node from Hg XML
   *
   * @param  Int $remote_nid    ID of node in Mercury
   * @return Object             The new node object
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
    if (!$node instanceof Node) { return FALSE; }
    $this->update_node_helper($node, $remote_node);
    $node->save();

    return $node;
  }

  /**
   * Offloads the nitty gritty of node updates.
   * @param  Object $node        The node being updated
   * @param  Array $remote_node  Node elements parsed from XML
   * @return Object $node        The updated node
   */
  function update_node_helper(&$node, $remote_node) {
    // just in case we get a slug
    if (!$node instanceof Node) { return; }

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
          'value' => isset($remote_node['article_dateline']) ? substr($remote_node['article_dateline'], 0, 10) : '',
        ]);
        $node->set('field_hg_publication', $remote_node['publication']);
        $node->set('field_hg_related_files', isset($remote_node['files']) ? $remote_node['files'] : '');
        break;

      case 'event':
        // Easy fields
        $node->set('field_hg_extras', $remote_node['extras']);
        $node->set('field_hg_fee', $remote_node['fee']);
        $node->set('field_hg_location', $remote_node['location']);
        $node->set('field_hg_location_email', $remote_node['locationemail']);
        $node->set('field_hg_location_phone', $remote_node['locationphone']);
        $node->set('field_hg_related_files', $remote_node['files']);
        $node->set('field_hg_related_links', $remote_node['links']);
        $node->set('field_hg_summary_sentence', $remote_node['sentence']);
        $node->set('field_hg_keywords', $this->process_terms($remote_node['keywords'], 'hg_keywords') ?: array());
        $node->set('field_hg_event_categories', $this->process_terms($remote_node['event_categories'], 'hg_event_categories') ?: array());
        $node->set('field_hg_invited_audience', $this->process_terms($remote_node['event_audience'], 'audience') ?: array());

        // Images
        $images = $this->process_images($remote_node['media']);
        if (!empty($images)) {
          foreach ($images as $key => $image) {
            $node->field_hg_images->set($key, $this->process_images($remote_node['media']) ?: array());
          }
        }

        // Groups
        foreach ($remote_node['groups'] as $key => $group) {
          $node->field_hg_groups->set($key, $group['name']);
        }

        // TODO: This is not in the serialized array but should be.
        // $node->set('field_hg_sidebar']          = $remote_node['sidebar']);

        // Contact
        $node->field_hg_contact->set(0, [
          'value' => $remote_node['contact'],
          'format' => $format,
        ]);

        // Event time
        $processed_time = $this->process_eventdate($remote_node['times'][0]['startdate'], $remote_node['times'][0]['stopdate'], $remote_node['times'][0]['timezone']);
        $node->field_hg_event_time->set(0, $processed_time);

        // Summary
        $node->field_hg_summary->set(0, [
          'value' => $remote_node['summary'],
          'format' => $format,
        ]);

        // Location URL
        $node->set('field_hg_location_url', [
          'uri' => strpos($remote_node['locationurl'], 'http') != 0 ? 'http://' . $remote_node['locationurl'] : $remote_node['locationurl'],
          'title' => $remote_node['locationurltitle'],
        ]);

        // Links
        foreach ($remote_node['links'] as $key => $link) {
          // This is stupid just beyond belief.
          $link['uri'] = $link['linkurl'];
          $link['title'] = $link['linktitle'];
          unset($link['linkurl']);
          unset($link['linktitle']);

          $node->field_hg_related_links->set($key, $link);
        }

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
        $node->field_hg_dateline->set(0, [
          'value' => substr($remote_node['dateline'], 0, 10),
        ]);
        $node->set('field_hg_email', $remote_node['contact_email']);
        $node->set('field_hg_location', $remote_node['location']);
        $node->set('field_hg_related_files', $remote_node['files']);
        $node->set('field_hg_subtitle', $remote_node['subtitle']);
        $node->set('field_hg_summary_sentence', $remote_node['sentence']);
        $node->set('field_hg_keywords', $this->process_terms($remote_node['keywords'], 'hg_keywords') ?: array());
        $node->set('field_hg_categories', $this->process_terms($remote_node['categories'], 'hg_categories') ?: array());
        $node->set('field_hg_core_research_areas', $this->process_terms($remote_node['core_research_areas'], 'hg_core_research_areas') ?: array());
        $node->set('field_hg_news_room_topics', $this->process_terms($remote_node['news_room_topics'], 'hg_news_room_topics') ?: array());

        $images = $this->process_images($remote_node['hg_media']);
        if (!empty($images)) {
          $i = 0;
          foreach ($images as $image) {
            $node->field_hg_images->set($i, $image);
          }
        }

        $videos = $this->process_videos($remote_node['hg_media']);
        if (!empty($videos)) {
          $i = 0;
          foreach ($videos as $video) {
            $node->field_hg_youtube_video->set($i, $this->process_videos($remote_node['hg_media']) ?: array());
          }
        }

        // Contact
        $node->field_hg_contact->set(0, [
          'value' => $remote_node['contact'],
          'format' => $format,
        ]);

        // Summary
        $node->field_hg_summary->set(0, [
          'value' => $remote_node['summary'],
          'format' => $format,
        ]);

        // Sidebar
        $node->field_hg_sidebar->set(0, [
          'value' => $remote_node['sidebar'],
          'format' => $format,
        ]);

        // Links
        foreach ($remote_node['links'] as $key => $link) {
          // This is stupid just beyond belief.
          $link['uri'] = $link['linkurl'];
          $link['title'] = $link['linktitle'];
          unset($link['linkurl']);
          unset($link['linktitle']);

          $node->field_hg_related_links->set($key, $link);
        }

        break;

      case 'profile':
        // The easy fields
        $node->set('field_hg_department',           $remote_node['department']);
        $node->set('field_hg_first_name',           $remote_node['firstname']);
        $node->set('field_hg_middle_name',          $remote_node['middlename']);
        $node->set('field_hg_last_name',            $remote_node['lastname']);
        $node->set('field_hg_nickname',             $remote_node['nickname']);
        $node->set('field_hg_mobile_phone',         $remote_node['cell']);
        $node->set('field_hg_phone_number',         $remote_node['phone']);
        $node->set('field_hg_fax_number',           $remote_node['fax']);
        $node->set('field_hg_primary_email',        $remote_node['primaryemail']);
        $node->set('field_hg_secondary_email',      $remote_node['secondaryemail']);
        $node->set('field_hg_street_address',       $remote_node['address']);
        $node->set('field_hg_city',                 $remote_node['city']);
        $node->set('field_hg_state',                $remote_node['state']);
        $node->set('field_hg_zip_code',             $remote_node['zipcode']);
        $node->set('field_hg_college_school',       $remote_node['college_school']);
        $node->set('field_hg_job_title',            $remote_node['jobtitle']);
        $node->set('field_hg_alternate_job_title',  $remote_node['alttitle']);
        $node->set('field_hg_summary',              $remote_node['summary']);
        $node->set('field_hg_teaching',             $remote_node['teaching']);
        $node->set('field_hg_specialty',            $remote_node['specialty']);
        $node->set('field_hg_research',             $remote_node['research']);
        $node->set('field_hg_linkedin',             $remote_node['linkedin']);
        $node->set('field_hg_twitter',              $remote_node['twitter']);

        // These fields need to provide sane defaults
        $node->set('field_hg_expertise', $this->process_terms($remote_node['expertise'], 'hg_expertise') ?: array());
        $node->set('field_hg_related_files', $this->process_files($remote_node['files']) ?: array());

        // Convert degree to appropriate taxonomy key
        $degree = strtolower(preg_replace('/\s+/', '_', $remote_node['degree']));
        $node->set('field_hg_degree', $degree);

        // Convert classifications to appropriate taxonomy key
        foreach ($remote_node['classifications'] as $classification) {
          $classification = strtolower(preg_replace('/\s+/', '_', $classification));
          $node->set('field_hg_classification', $classification);
        }

        // Media processing is offloaded to a helper function.
        $media = $this->process_media($remote_node['hg_media']);
        if (!empty($media)) {
          foreach ($media as $key => $item) {
            $node->field_hg_media->set($key, $item);
          }
        }

        // Links
        foreach ($remote_node['links'] as $key => $link) {
          $node->field_hg_related_links->set($key, $link);
        }

        // Recent news field may require importation of additional nodes.
        foreach ($remote_node['recent_news'] as $hg_id) {
          $query = \Drupal::entityQuery('node')
            ->accessCheck(TRUE)
            ->condition('field_hg_id', $hg_id);
            $referenced = $query->execute();
          // This item is in the system already
          if (!empty($referenced)) {
            $referenced = reset($referenced);
            // Do we alrady have this item in the field?
            $match = FALSE;
            foreach ($node->field_hg_recent_appearances as $item) {
              $nid = $item->getValue();
              if ($referenced == $nid['target_id']) {
                $match = TRUE;
              }
            }
            // If it's not already in the field, add it.
            if ($match == FALSE) {
              $node->field_hg_recent_appearances->set($node->field_hg_recent_appearances->count(), $referenced);
            }
          } else {
            // Item is not in the system. We need to import it and add it to the field.
            $new_node_xml = $this->pull_remote($hg_id, 'item');
            $new_node_raw = unserialize($this->serialize_xml($new_node_xml, 'Item'));
            $this->decode($new_node_raw);
            $new_node = $this->create_node($new_node_raw, $this->id());
            $node->field_hg_recent_appearances->set($node->field_hg_recent_appearances->count(), $new_node->id());
          }
        }
    }
  }

  /**
   * Create media entities corresponding to incoming media items and reference
   * them in the current node.
   * @param array $media Array of media elements
   * @param string $type Media type
   * @return [type] [description]
   */
  function process_media($media) {
    $media_list = [];
    /** @var FileSystemInterface $file_system */
    $file_system = \Drupal::service('file_system');
    /** @var FileRepositoryInterface $file_repository */
    $file_repository = \Drupal::service('file.repository');

    foreach ($media as $item) {
      if ($item['type'] == 'image') {
        $file_data = file_get_contents($item['image_path']);
        $directory_uri = 'public://' . date('Y-d');
        $file_system->prepareDirectory($directory_uri, FileSystemInterface::CREATE_DIRECTORY|FileSystemInterface::MODIFY_PERMISSIONS);
        $file = $file_repository->writeData($file_data, $directory_uri . '/' . $item['image_name'], FileSystemInterface::EXISTS_REPLACE);

        $media_entity = Media::create([
          'bundle' => 'hg_image',
          'field_media_hg_image' => [
              'target_id' => $file->id(),
              'alt' => $item['title'],
              'title' => $item['title'],
            ],
          ]);
        $media_entity->setName($item['title'])
          ->setPublished(TRUE)
          ->save();

        $media_list[] = [
          'target_id' => $media_entity->id(),
        ];
      } else if ($item['type'] == 'video') {
        $media_entity = Media::create([
          'bundle' => 'hg_video',
          'field_media_hg_video' => [
              'value' => $item['youtube_id'],
            ],
          ]);
        $media_entity->setName($item['title'])
          ->setPublished(TRUE)
          ->save();

        $media_list[] = [
          'target_id' => $media_entity->id(),
        ];
      }
    }
    return $media_list;
  }

  /**
   * DEPRECATED--we'll be moving everything to media soon.
   * @return [type] [description]
   */
  function process_images($images) {
    if (is_null($images)) { return FALSE; }

    $config = \Drupal::config('hg_reader.settings');
    $hg_url = $config->get('hg_url');

    // TODO: Image path should be part of the module's configuration.
    $image_path = 'public://hg_media';
    if (\Drupal::service('file_system')->prepareDirectory($image_path, FileSystemInterface::CREATE_DIRECTORY)) {
      $image_list = array();

      foreach ($images as $image) {
        if (!empty($image['youtube_id'])) {
          continue;
        } else if (!isset($image['image_path']) || empty($image['image_path'])) {
          continue;
        } else if (!$data = @file_get_contents($image['image_path'])) { continue; }
        $file = \Drupal::service('file.repository')->writeData($data, 'public://' . 'hg_media/' . $image['image_name'], FileSystemInterface::EXISTS_REPLACE);
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
   * DEPRECATED--we'll be moving everything to media soon.
   * @return [type] [description]
   */
  function process_videos($videos) {
    if (is_null($videos)) { return FALSE; }

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
   * [process_files description]
   * @return [type] [description]
   */
  function process_files($files) {
    $config = \Drupal::config('hg_reader.settings');
    $hg_url = $config->get('hg_url');

    // TODO: File path should be part of the module's configuration.
    $local_path = 'public://hg_attachments';
    if (\Drupal::service('file_system')->prepareDirectory($local_path, FileSystemInterface::CREATE_DIRECTORY)) {
      $file_list = array();

      foreach ($files as $file) {
        if ($file['filepath'] == '') {
          continue;
        } else if (!$data = @file_get_contents($file['filepath'])) { continue; }
        $raw = \Drupal::service('file.repository')->writeData($data, $local_path . '/' . $file['filename'], FileSystemInterface::EXISTS_REPLACE);
        $fid = $raw->get('fid')->first()->getValue()['value'];
        $file_list[] = ['target_id' => $fid];
      }
      return $file_list;

    } else {
      // TODO: Oh Lord
      \Drupal::messenger()->addMessage(t('Destination directory is faulty.'), 'error');
      return FALSE;
    }
  }

  /**
   * [process_terms description]
   * @param  [type] $keywords [description]
   * @return [type]           [description]
   */
  function process_terms($rawterms, $vid = NULL) {
    if (empty($rawterms)) { return FALSE; }
    $tids = array();
    foreach ($rawterms as $rawterm) {
      if (is_array($rawterm)) { $rawterm = $rawterm[$vid] ?: $rawterm['term'] ; }
      $terms = \Drupal::entityTypeManager()->getStorage("taxonomy_vocabulary")->loadByProperties(["name" => $rawterm, "vid" => $vid]);
      if ($terms == NULL) {
        $created = $this->create_term($rawterm, $vid);
        if ($created) {
          $new_terms = \Drupal::entityTypeManager()->getStorage("taxonomy_vocabulary")->loadByProperties(["name" => $rawterm, "vid" => $vid]);
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
        ->accessCheck(TRUE)
        ->condition('field_hg_importer', $iid)
        ->execute();

    // Get entities associated with this feed.
    $node_storage_handler = \Drupal::entityTypeManager()->getStorage('node');
    $media_storage_handler = \Drupal::entityTypeManager()->getStorage('media');
    $entities = $node_storage_handler->loadMultiple($result);

    // Delete all related media items for profiles.
    foreach ($entities as $entity) {
      if ($entity->type->getValue()[0]['target_id'] == 'hg_profile') {
        foreach ($entity->field_hg_media->referencedEntities() as $media) {
          $media->delete();
        }
      }
    }

    // Delete all feed nodes.
    $node_storage_handler->delete($entities);

    \Drupal::messenger()->addMessage(t('Deleted all content from <em>@name</em>.', array('@name' => $name['value'])), 'status');
  }

  /**
   * Return count of items associated with this importer.
   *
   */
  function countAllImporterItems($iid) {
    $query = \Drupal::entityQuery('node')
      ->accessCheck(FALSE)
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

  /**
   * Helper function for event time processing
   *
   * @param  Timestamp $raw_start Timestamp of event start time
   * @param  Timestamp $raw_end   Timestamp of event end time
   * @param  String    $timezone  String representation of time zone
   *
   * @return Array                Array representation of a time
   */
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
