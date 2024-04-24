<?php
/**
* Georgia Institute of Technology Mercury Feed Reader
*
* This file contains functions used to read and display Mercury feeds (hg.gatech.edu)
*
* @author Office of Communications and Marketing <web@comm.gatech.edu>
*
*/

namespace Drupal\hg_reader\Controller;

use Drupal\Core\Controller\ControllerBase;
use Drupal\Core\Database\Connection;
use Drupal\Core\Messenger\MessengerInterface;
use Drupal\hg_reader\HgImporterInterface;
use Drupal\node\NodeInterface;
use Symfony\Component\DependencyInjection\ContainerInterface;
use Symfony\Component\HttpFoundation\JsonResponse;

/**
 * Returns responses for aggregator module routes.
 */
class HgImporterController extends ControllerBase {

  /**
   * The messenger service.
   *
   * @var \Drupal\Core\Messenger\MessengerInterface
   */
  protected $messenger;
  protected $database;

  /**
   * {@inheritdoc}
   */
  public function __construct(MessengerInterface $messenger = NULL, Connection $database = NULL) {
    if ($messenger) {
      $this->messenger = $messenger;
    }
    if ($database) {
      $this->database = $database;
    }
  }

  /**
   * {@inheritdoc}
   */
  public static function create(ContainerInterface $container) {
    return new static(
      $container->get('messenger'),
      $container->get('database')
    );
  }

  /**
   * Process a single importer:
   *    - Delete nodes that have been deleted in Mercury
   *    - Update nodes that have been updated since importer was last processed.
   *    - Import any new nodes.
   * @param  HgImporter  $hg_reader_importer  The importer object
   *
   */
  public function process_importer(HgImporterInterface $hg_reader_importer) {
    // Delete nodes on delete list.
    if (!isset($this->full_deleted_list)) {
      $this->full_deleted_list = $hg_reader_importer->get_deleted();
    }

    $hg_reader_importer->delete_tracked($hg_reader_importer, $this->full_deleted_list);

    // Update nodes on update list.
    $this->update_nodes($hg_reader_importer);

    // Pull new nodes
    $this->import_nodes($hg_reader_importer);

    // return to importer list
    return $this->redirect('entity.hg_reader_importer.collection');
  }

  /**
   * High level import of all new nodes.
   * @param  HgImporter  $hg_reader_importer  The importer object
   *
   */
  public function import_nodes(HgImporterInterface $hg_reader_importer) {
    // Is fid a multi-value?
    $fid_count = $hg_reader_importer->get('fid')->count();
    if ($hg_reader_importer->get('fid')->count() > 1) {
      for ($i = 0; $i < $fid_count; $i++) {
        $fid = $hg_reader_importer->get('fid')->get($i)->getString();
        $this->import_nodes_single($hg_reader_importer, $fid);
      }
    } else {
      $fid = $hg_reader_importer->get('fid')->getString();
      $this->import_nodes_single($hg_reader_importer, $fid);
    }
  }

  /**
   * Import a single node from a node ID.
   * @param  HgImporter $hg_reader_importer  The importer object
   * @param  String $fid                     The ID of the node to be imported.
   *
   */
  public function import_nodes_single(HgImporterInterface $hg_reader_importer, string $fid) {
    $iid = $hg_reader_importer->get('id')->getString();
    $name = $hg_reader_importer->get('name')->getString();

    // First check if this even needs doing.
    if (!$hg_reader_importer->audit_remote($fid)) {
      if ($this->messenger) {
        $this->messenger->addMessage($this->t('Nothing to import from <em>@importer_name</em>.',
          array(
            '@importer_name' => $name,
          )
        ));
      }

       // If it doesnt need to be done, we still need to update "Last_run" since update_nodes doesnt do it anywhere.
      $hg_reader_importer->set('last_run', time());
      $hg_reader_importer->save();

      return $this->redirect('entity.hg_reader_importer.collection');
    }

    // pull data for this importer
    $xml = $hg_reader_importer->pull_remote($fid);

    // TODO: Error handling here. Ha ha ha.
    // if (!$xml) { continue; }

    // get serialized, decoded array
    $rawnodes = unserialize($hg_reader_importer->serialize_xml($xml));
    $hg_reader_importer->decode($rawnodes);

    // create nodes
    $node_count = 0;
    foreach ($rawnodes as $rawnode) {
      // If this is an event with repeats, we need to make a node for each one.
      if (isset($rawnode['times']) && is_array($rawnode['times']) && count($rawnode['times']) > 1) {
        $times = $rawnode['times'];
        foreach ($times as $time) {
          $rawnode['times'] = array($time);
          $rawnode['start'] = $time['startdate'];
          $rawnode['end'] = $time['stopdate'];
          $created = $hg_reader_importer->create_node($rawnode, $iid);
          if (is_object($created)) { $node_count++; }
        }
      } else {
        $created = $hg_reader_importer->create_node($rawnode, $iid);
        if (is_object($created)) { $node_count++; }
      }
    }

    // bubblegum, bubblgum in a dish, how many nodes did you import?
    if ($this->messenger) {
      $this->messenger->addMessage($this->t('@count nodes imported from <em>@importer_fid</em>.',
        array(
          '@count' => $node_count,
          '@importer_fid' => $fid,
        )
      ));
    }

    // Stamp the importer with the current time.
    $hg_reader_importer->set('last_run', time());
    $hg_reader_importer->save();
	}

  /**
   * Update nodes that have been updated in Mercury since last run.
   * @param  HgImporter  $hg_reader_importer  The importer object
   *
   */
  public function update_nodes(HgImporterInterface $hg_reader_importer) {
    $name = $hg_reader_importer->get('name')->getString();
    $last_run = $hg_reader_importer->get('last_run')->getString() ?: time();

    $update_list = $hg_reader_importer->pull_updates($last_run);

    $update_count = 0;
    foreach ($update_list as $nid) {
      if ($result = $hg_reader_importer->update_node($nid)) {
        $update_count++;
      }
    }

    if ($this->messenger && $update_count > 0) {
      $this->messenger->addMessage($this->t('@count nodes updated from <em>@importer</em>.',
        array(
          '@count' => $update_count,
          '@importer' => $hg_reader_importer->name->getValue()[0]['value'],
        )
      ));
    }
  }

  /**
   * Log everything of course.
   * @param  Node $node   Take a guess.
   *
   */
  public function log(NodeInterface $node = NULL) {
    if (!$node) { return new JsonResponse(); }
    if ($node->hasField('field_hg_id')) { $nid = $node->get('field_hg_id')->getString(); }
    else if ($node->hasField('field_hg_id')) { $nid = $node->get('field_hg_id')->getString(); }
    else { return new JsonResponse(); }

    $this->database
      ->insert('hg_reader_log')
      ->fields([
        'nid' => $nid,
        'timestamp' => time()
      ])
      ->execute();

    // Send back a nonce.
    return new JsonResponse();
  }
}
