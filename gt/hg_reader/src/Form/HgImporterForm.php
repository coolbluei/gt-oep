<?php

namespace Drupal\hg_reader\Form;

use Drupal\Core\Entity\ContentEntityForm;
use Drupal\Core\Language\Language;
use Drupal\Core\Form\FormStateInterface;
use Drupal\Core\Messenger\MessengerInterface;

/**
 * Form controller for the hg_reader entity edit forms.
 *
 * @ingroup hg_reader
 */
class HgImporterForm extends ContentEntityForm {
  /**
   * {@inheritdoc}
   */
  public function buildForm(array $form, FormStateInterface $form_state) {
    /* @var $entity \Drupal\hg_reader\Entity\HgImporter */
    $form = parent::buildForm($form, $form_state);
    $entity = $this->entity;

    $form['langcode'] = array(
      '#title' => $this->t('Language'),
      '#type' => 'language_select',
      '#default_value' => $entity->getUntranslated()->language()->getId(),
      '#languages' => Language::STATE_ALL,
    );
    return $form;
  }

  /**
   * {@inheritdoc}
   */
  public function save(array $form, FormStateInterface $form_state) {
    $status = parent::save($form, $form_state);

    $entity = $this->entity;
    if ($status == SAVED_UPDATED) {
      \Drupal::messenger()->addMessage($this->t('The importer %importer has been updated.', ['%importer' => $entity->toLink()->toString()]));
    } else {
      \Drupal::messenger()->addMessage($this->t('The importer %importer has been added.', ['%importer' => $entity->toLink()->toString()]));
    }

    $form_state->setRedirectUrl($this->entity->toUrl('collection'));
    return $status;
  }
}

?>
