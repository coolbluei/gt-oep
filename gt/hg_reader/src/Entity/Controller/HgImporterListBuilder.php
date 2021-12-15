<?php

namespace Drupal\hg_reader\Entity\Controller;

use Drupal\Core\Entity\EntityInterface;
use Drupal\Core\Entity\EntityListBuilder;
use Drupal\Core\Url;

/**
 * Provides a list controller for hg_reader_importer entity.
 *
 * @ingroup hg_reader
 */
class HgImporterListBuilder extends EntityListBuilder {

  /**
   * {@inheritdoc}
   *
   * We override ::render() so that we can add our own content above the table.
   * parent::render() is where EntityListBuilder creates the table using our
   * buildHeader() and buildRow() implementations.
   */
  public function render() {
    $build['description'] = [
      '#markup' => $this->t('Every item imported using Mercury importers is tied to the importer that imported it, meaning if you delete the importer, the content will be deleted as well. You can manage the fields on Mercury importers on the <a href="@adminlink">Mercury importers admin page</a>.', array(
        '@adminlink' => \Drupal::urlGenerator()
          ->generateFromRoute('entity.hg_reader_importer.settings'),
      )),
    ];

    $build += parent::render();
    return $build;
  }

  /**
   * {@inheritdoc}
   *
   * Calling the parent::buildHeader() adds a column for the possible actions
   * and inserts the 'edit' and 'delete' links as defined for the entity type.
   */
  public function buildHeader() {
    $header['id'] = $this->t('Importer ID');
    $header['name'] = $this->t('Name');
    $header['fid'] = $this->t('Feed ID');
    return $header + parent::buildHeader();
  }

  /**
   * {@inheritdoc}
   */
  public function buildRow(EntityInterface $entity) {
    /* @var $entity \Drupal\hg_reader\Entity\HgImporter */
    $row['id'] = $entity->id();
    $row['name'] = $entity->link();
    $fids_array = $entity->fid->getValue();
    $fids = [];
    foreach ($fids_array as $fid) {
      $fids[] = $fid['value'];
    }
    $row['fid'] = implode(', ', $fids);
    return $row + parent::buildRow($entity);
  }

  protected function getDefaultOperations(EntityInterface $entity) {
    $operations = parent::getDefaultOperations($entity);

    /** @var \Drupal\commerce_order\Entity\OrderInterface $entity */
    if ($entity->access('update')) {
      $operations['process-importer'] = [
        'title' => $this->t('Import/update content'),
        'weight' => 20,
        'url' => $entity->toUrl('process-importer'),
      ];
      $operations['delete-nodes'] = [
        'title' => $this->t('Delete content'),
        'weight' => 22,
        'url' => $entity->toUrl('delete-nodes-form'),
      ];
    }

    return $operations;
  }


}
?>
