<?php

namespace Drupal\pcol\Entity\Controller;

use Drupal\Core\Entity\EntityInterface;
use Drupal\Core\Entity\EntityListBuilder;
use Drupal\Core\Url;

/**
 * Provides a list controller for pcol entity.
 *
 * @ingroup pcol
 */
class PcolListBuilder extends EntityListBuilder {

  /**
   * {@inheritdoc}
   *
   * Calling the parent::buildHeader() adds a column for the possible actions
   * and inserts the 'edit' and 'delete' links as defined for the entity type.
   */
  public function buildHeader() {
   $header = array(
     'id' => array(
       'data' => $this->t('ID'),
       'field' => 'id',
       'specifier' => 'id',
     ),
   );

   return $header + parent::buildHeader();
  }

  /**
   * {@inheritdoc}
   */
  public function buildRow(EntityInterface $entity) {
    /* @var $entity \Drupal\pcol\Entity\Pcol */
    $row['id'] = $entity->get('id')->getString();
    return $row + parent::buildRow($entity);
  }

  /**
   * {@inheritdoc}
   */
  public function load() {
    $entity_query = \Drupal::service('entity.query')->get('pcol');
    $header = $this->buildHeader();

    $entity_query->pager(50);
    $entity_query->tableSort($header);

    $uids = $entity_query->execute();

    return $this->storage->loadMultiple($uids);
  }
}
