<?php

use Drupal\datetime\Plugin\Field\FieldType\DateTimeItemInterface;
use Drupal\Core\Datetime\DrupalDateTime;
use Drupal\hg_reader\Entity\HgImporter;
use Drupal\node\Entity\Node;
use Drupal\taxonomy\Entity\Term;
use Drupal\taxonomy\Entity\Vocabulary;

/**
 * Rebuild taxonomy terms for orphaned metadata entities. This was previously
 * done in 8003 but needs to be done again and in post_update rather than hook_N.
 */
function hg_reader_post_update_rebuild_terms(&$sandbox) {
  $hg_fields = getHgFieldMapping();

  // Initialize batching
  if (!isset($sandbox['progress'])) {
    $sandbox['nids'] = getHgEntities();
    $sandbox['max'] = count($sandbox['nids']);
    if (empty($sandbox['max'])) {
      $sandbox['#finished'] = 1;
      return;
    }

    // Other sandbox variables
    $sandbox['progress'] = 0;
    $sandbox['nodes_per_batch'] = 20;
    $sandbox['processed_nodes'] = 0;
    $sandbox['processed_terms'] = 0;
  }

  // Set a range for the current batch.
  $range_end = $sandbox['progress'] + $sandbox['nodes_per_batch'];
  if ($range_end > $sandbox['max']) { $range_end = $sandbox['max']; }

  // Loop the current batch and do the thing.
  for ($i = $sandbox['progress']; $i < $range_end; $i++) {
    $bool_update = FALSE;
    if ($sandbox['nids'][$i] == 0) { continue; }
    $node = Node::load($sandbox['nids'][$i]);
    if (is_null($node)) { continue; }

    foreach ($hg_fields as $hg_field => $hg_field_vocab) {
      if (!$node->hasField($hg_field)) { continue; }

      $vid = Vocabulary::load($hg_field_vocab)->id();

      // Checking field reference value
      $categories = $node->$hg_field->getValue();
      if (empty($categories)) { continue; }

      foreach ($categories as $category) {
        // Load the taxonomy term based on id
        $term = Term::load($category['target_id']);

        // Checking vocabulary of term
        if (is_null($term) || $term->bundle() == $vid) { continue; }

        // Check to see if term exists in the current vocabulary
        $term_exists_in_vocab = taxonomy_term_load_multiple_by_name($term->getName(), $vid);
        // If empty, then term does not exist in vocab, so build
        if (empty($term_exists_in_vocab)) {
          $term_new = Term::create([
            'name' => $term->getName(),
            'vid' => $vid,
          ]);
          $term_new->save();
          $sandbox['processed_terms']++;
        } else {
          $term_new = current($term_exists_in_vocab);
        }

        // Finally, replace Tax reference with the newly created entity
        // sourced from https://drupal.stackexchange.com/questions/262090/how-do-i-programmatically-delete-a-reference-field-values
        $node->get($hg_field)->removeItem(array_search(current($category), array_column($categories, key($category))));

        // Now, replace that relationship
        $node->get($hg_field)->appendItem(['target_id' => $term_new->id()]);
        \Drupal::logger('hg_reader')->notice('Updated ' . $term_new->getName() . '[' . $term_new->id() . '] for ' . $node->label() . '[nid=' . $node->id() . ']');
        $bool_update = TRUE;
      }
    }

    if ($bool_update) {
      $node->save();
      $sandbox['processed_nodes']++;
    }
  }

  // Update the batch variables
  $sandbox['progress'] = $range_end;
  $progress_fraction = $sandbox['progress'] / $sandbox['max'];
  $sandbox['#finished'] = empty($sandbox['max']) ? 1 : $progress_fraction;

  \Drupal::logger('hg_reader')->notice('Progress: ' . (round($progress_fraction * 100)) . '% (' . $sandbox['progress'] . ' of ' . $sandbox['max'] . ' nodes processed)');
  if ($sandbox['#finished'] == 1) {
    \Drupal::messenger()->addMessage(t('Recreated @terms term(s) across @items item(s).', array('@terms' => $sandbox['processed_terms'], '@items' => $sandbox['processed_nodes'])), 'status');
  }
}

/**
 * Remove duplicate terms from vocabularies.
 */
function hg_reader_post_update_remove_duplicate_terms(&$sandbox) {
  $hg_fields = getHgFieldMapping();

  // Initialize batching
  if (!isset($sandbox['progress'])) {
    $sandbox['nids'] = getHgEntities();
    $sandbox['max'] = count($sandbox['nids']);
    if (empty($sandbox['max'])) {
      $sandbox['#finished'] = 1;
      return;
    }

    // Other sandbox variables
    $sandbox['progress'] = 0;
    $sandbox['nodes_per_batch'] = 20;
    $sandbox['processed_nodes'] = 0;
    $sandbox['processed_terms'] = 0;
  }

  // Set a range for the current batch.
  $range_end = $sandbox['progress'] + $sandbox['nodes_per_batch'];
  if ($range_end > $sandbox['max']) { $range_end = $sandbox['max']; }

  // Loop the current batch and do the thing.
  for ($i = $sandbox['progress']; $i < $range_end; $i++) {
    $bool_update = FALSE;
    if ($sandbox['nids'][$i] == 0) { continue; }
    $node = Node::load($sandbox['nids'][$i]);
    if (is_null($node)) { continue; }

    foreach ($hg_fields as $hg_field => $hg_field_vocab) {
      if (!$node->hasField($hg_field)) { continue; }

      $vid = Vocabulary::load($hg_field_vocab)->id();

      // Checking field reference value
      $categories = $node->$hg_field->getValue();
      if (empty($categories)) { continue; }

      foreach ($categories as $category) {
        // Load the taxonomy term based on id
        $term = Term::load($category['target_id']);

        // Checking vocabulary of term
        if (is_null($term)) { continue; }

        // Find the authoritative term for the meta.
        $term_authoritative = array_shift(taxonomy_term_load_multiple_by_name($term->getName(),$vid));
        // Reference authoritative term and delete the dupe.
        if ($term->id() == $term_authoritative->id()) { continue; }

        // Remove the taxonomy term from the list.
        // https://drupal.stackexchange.com/questions/262090/how-do-i-programmatically-delete-a-reference-field-values
        $key = array_search(current($category), array_column($categories, key($category)));
        $node->get($hg_field)->removeItem($key);

        // Delete the duplicate taxonomy term.
        // https://drupal.stackexchange.com/questions/213256/how-to-delete-a-vocabulary-terms-programmatically
        $delete_term_controller = \Drupal::entityTypeManager()->getStorage('taxonomy_term');
        $delete_term_term = $delete_term_controller->load($term->id());
        $delete_term_controller->delete(array($delete_term_term));
        $sandbox['processed_terms']++;
        \Drupal::logger('hg_reader')->notice('Deleted duplicate term ' . $term->id() . '.');

        // Properly adding the authoritative owner there.
        $node->get($hg_field)->appendItem(['target_id' => $term_authoritative->id()]);
        $bool_update = TRUE;
      }
    }
    if ($bool_update) {
      $node->save();
      $sandbox['processed_nodes']++;
      \Drupal::logger('hg_reader')->notice('Updated [nid=' . $node->id() . ']' . $node->label());
    }
  }

  // Update the batch variables
  $sandbox['progress'] = $range_end;
  $progress_fraction = $sandbox['progress'] / $sandbox['max'];
  $sandbox['#finished'] = empty($sandbox['max']) ? 1 : $progress_fraction;

  \Drupal::logger('hg_reader')->notice('Progress: ' . (round($progress_fraction * 100)) . '% (' . $sandbox['progress'] . ' of ' . $sandbox['max'] . ' nodes processed)');
  if ($sandbox['#finished'] == 1) {
    \Drupal::messenger()->addMessage(t('Deleted @terms duplicate term(s) across @items item(s).', array('@terms' => $sandbox['processed_terms'], '@items' => $sandbox['processed_nodes'])), 'status');
  }
}

/**
 * Remove oprhaned terms from vocabularies.
 */
function hg_reader_post_update_remove_orphaned_terms(&$sandbox) {
  $vocabularies = array_values(getHgFieldMapping());

  // After curating terms attached to entities, we may have orphaned terms. How they came about? I can't tell.
  // In this case, load the authoritative term for each term_name and destroy the rest in the array.
  foreach ($vocabularies as $vocabulary_machine) {
    $vocabulary = Vocabulary::load($vocabulary_machine);
    // If a vocab doesn't exit, we got problems.
    if (empty($vocabulary)) { continue; }
    // https://drupal.stackexchange.com/questions/217493/how-can-i-get-the-taxonomy-tree-by-the-vocabulary-id
    $vocabulary_terms = \Drupal::entityTypeManager()->getStorage('taxonomy_term')->loadTree($vocabulary->id(), 0, 1, TRUE);
    if (sizeof($vocabulary_terms) == 0) { continue; }
    foreach ($vocabulary_terms as $vocabulary_term) {
      $term = Term::load($vocabulary_term->id());
      // If term doesn't exist, it's probably already been deleted.
      if (empty($term)) { continue; }
      $terms_to_delete = taxonomy_term_load_multiple_by_name($term->getName(),$vocabulary->id());
      $term_authoritative = array_shift($terms_to_delete);
      // If we have no terms to delete, continue on.
      if (empty($terms_to_delete)) { continue; }
      if ($term->id() == $term_authoritative->id()) { continue; }
      // Delete the term.
      foreach ($terms_to_delete as $term_to_delete) {
        $term_to_delete->delete();
      }
      \Drupal::logger('hg_reader')->notice('Deleted ' .  sizeof($terms_to_delete) . ' non-authoritative terms for ' . $term_authoritative->id() . ' ' .  $term_authoritative->label() . '.');
    }
  }
}

/**
 * Change dates originally stored as 'America\New York' to 'UTC'. This is a
 * slow process; be patient.
 */
function hg_reader_post_update_fix_timezones(&$sandbox) {

  // Initialize batching
  if (!isset($sandbox['progress'])) {
    // Pull all events with starting date >= now.
    $now = new DrupalDateTime('now');
    $now->setTimezone(new \DateTimeZone(DateTimeItemInterface::STORAGE_TIMEZONE));
    $nids = \Drupal::entityQuery('node')
      ->accessCheck(FALSE)
      ->condition('type','hg_event')
      ->condition('field_hg_event_time.value', $now->format(DateTimeItemInterface::DATETIME_STORAGE_FORMAT), '>=')
      ->execute();

    // Set sandbox max, exit if zero.
    $sandbox['max'] = count($nids);
    if (empty($sandbox['max'])) {
      $sandbox['#finished'] = 1;
      return;
    }

    // Other sandbox variables
    $sandbox['progress'] = 0;
    $sandbox['nodes_per_batch'] = 5;
    $sandbox['nids'] = $nids;
  }

  // Set a range for the current batch.
  $range_end = $sandbox['progress'] + $sandbox['nodes_per_batch'];
  if ($range_end > $sandbox['max']) { $range_end = $sandbox['max']; }

  // Loop the current batch and do the thing.
  for ($i = $sandbox['progress']; $i < $range_end; $i++) {
    $node = Node::load(array_pop($sandbox['nids']));
    if (is_null($node)) { continue; }

    $node_hg_id = $node->get('field_hg_id')->getString();
    $node_hg_event_start = $node->get('field_hg_event_time')->getValue()[0]['value'];
    // Compare stored date versus hg date
    // hg URL, e.g. https://hg.gatech.edu/node/650591/xml
    if(!empty($node_hg_id)){
      $importer = HgImporter::load($node->get('field_hg_importer')->getString());
      $remote_xml = $importer->pull_remote($node_hg_id, 'item');
      $remote_node = unserialize($importer->serialize_xml($remote_xml, 'Item'));
      $importer->decode($remote_node);
      $remote_dates = $importer->process_eventdate($remote_node['times'][0]['startdate'], $remote_node['times'][0]['stopdate'], $remote_node['times'][0]['timezone']);

      if (!empty(strcmp($remote_dates['value'], $node_hg_event_start))){
        // currently stored start date doesn't match the UTC version in DB, update this.
        $node->set('field_hg_event_time', $remote_dates);
        $node->save();
        \Drupal::logger('hg_reader')->notice("Stored datetime pair " . $remote_dates['value'] . "|" . $remote_dates['end_value'] . " for '" . $node->getTitle() . "'.");
      } else {
        \Drupal::logger('hg_reader')->notice("No processing required for '" . $node->getTitle() . "'.");
      }
    }
  }

  // Update the batch variables
  $sandbox['progress'] = $range_end;
  $progress_fraction = $sandbox['progress'] / $sandbox['max'];
  $sandbox['#finished'] = empty($sandbox['max']) ? 1 : $progress_fraction;

  \Drupal::logger('hg_reader')->notice('Progress: ' . (round($progress_fraction * 100)) . '% (' . $sandbox['progress'] . ' of ' . $sandbox['max'] . ' nodes processed)');
}




/**
 * Helper function returning an array mapping hg node fields to taxonomies
 */
function getHgFieldMapping() {
  return [
    'field_hg_keywords' => 'hg_keywords',
    'field_hg_categories' => 'hg_categories',
    'field_hg_news_room_topics' => 'hg_news_room_topics',
    'field_hg_newsroom_topics' => 'hg_newsroom_topics',
    'field_hg_event_categories' => 'hg_event_categories',
    'field_hg_invited_audience' => 'hg_invited_audience'
  ];
}

/**
 * Helper function returning core hg entities
 */
function getHgEntities() {
  return \Drupal::entityQuery('node')
      ->accessCheck(FALSE)
      ->condition('type', ['hg_event', 'hg_news'], 'IN')
      ->execute();
}
