<?php

namespace Drupal\hg_reader\Form;

use Drupal\Core\Entity\ContentEntityConfirmFormBase;
use Drupal\Core\Form\FormStateInterface;
use Drupal\Core\Url;

/**
 * Provides a form for deleting a hg_reader_importer entity.
 *
 * @ingroup hg_reader
 */
class HgImporterImportNodesForm extends ContentEntityConfirmFormBase {

  /**
   * [getCancelUrl description]
   * @return [type] [description]
   */
  public function getCancelUrl() {
    return new Url('entity.hg_reader_importer.collection');
  }

  /**
   * [getQuestion description]
   * @return [type] [description]
   */
  public function getQuestion() {
    $entity_name = $this->entity->get('name')->first()->getValue();
    return $this
        ->t('Are you sure you want to import new content for "%entity_name"?', [
        '%entity_name' => $entity_name['value'],
      ]);
  }

  /**
   * [getConfirmText description]
   * @return [type] [description]
   */
  public function getConfirmText() {
    return $this->t('Import tons of useless content');
  }

  /**
   * {@inheritdoc}
   */
  public function submitForm(array &$form, FormStateInterface $form_state) {
    $id = $this->entity->get('id')->first()->getValue();
    $this->entity->import_nodes($id['value']);
    $form_state->setRedirectUrl($this->getCancelUrl());
  }
}
