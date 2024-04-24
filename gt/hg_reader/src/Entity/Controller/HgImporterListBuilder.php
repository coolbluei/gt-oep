<?php

namespace Drupal\hg_reader\Entity\Controller;

use Drupal\Core\Datetime\DrupalDateTime;
use Drupal\Core\Entity\EntityInterface;
use Drupal\Core\Entity\EntityListBuilder;
use Drupal\Core\Link;
use Drupal\Core\Render\Markup;
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
          ->generateFromRoute('hg_reader.admin_settings'),
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
    $header['last_run'] = $this->t('Last pull');
    $header['item_count'] = $this->t('# of items');
    return $header + parent::buildHeader();
  }

  /**
   * {@inheritdoc}
   */
  public function buildRow(EntityInterface $entity) {
    /* @var $entity \Drupal\hg_reader\Entity\HgImporter */
    $row['id'] = $entity->id();
    $row['name'] = $entity->toLink()->toString();
    $fids_array = $entity->fid->getValue();
    $fids = [];

    foreach ($fids_array as $fid) {
      if (!is_int($fid)) {
        $link = Link::fromTextAndUrl($fid['value'], Url::fromUri('https://hg.gatech.edu/node/' . $fid['value']))->toString();
        $fids[] = $link;
      }
    }
    $row['fid']['data']['#markup'] = implode(', ', $fids);

    $last_run = $entity->get('last_run')->getString();
    if ($last_run) {
      $row['last_run'] = DrupalDateTime::createFromTimestamp($entity->get('last_run')->getString())->format('D d M Y');
    } else {
      $row['last_run'] = 'n/a';
    }
    $row['item_count'] = $entity->countAllImporterItems($entity->id());
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
