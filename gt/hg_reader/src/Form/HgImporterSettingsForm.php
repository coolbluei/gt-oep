<?php

namespace Drupal\hg_reader\Form;

use Drupal\Core\Form\FormBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * Class ContentEntityExampleSettingsForm.
 * @package Drupal\hg_reader\Form
 * @ingroup hg_reader
 */
class HgImporterSettingsForm extends FormBase {
  /**
   * {@inheritdoc}
   */
  public function getFormId() {
    return 'hg_reader_admin_settings';
  }
  /**
   * {@inheritdoc}
   */
  protected function getEditableConfigNames() {
    return [
      'hg_reader.settings',
    ];
  }
  /**
   * {@inheritdoc}
   */
  public function buildForm(array $form, FormStateInterface $form_state) {
    // get the current configuration
    $config = $this->config('hg_reader.settings');
    // get all y'all's text formats
    $formats = \Drupal::entityQuery('filter_format')
        ->accessCheck(FALSE)
        ->execute();
    // use limited_html if it exists
    $default_format = array_search('limited_html', $formats) ? 'limited_html' : 'plain_text';
    // get the format entities and make a nice set of options
    $storage_handler = \Drupal::entityTypeManager()->getStorage('filter_format');
    $entities = $storage_handler->loadMultiple($formats);
    foreach ($formats as $format) {
      $formats[$format] = $entities[$format]->get('name');
    }
    // Mercury URL — variable to allow for debugging with a local copy of Mercury
    $form['hg_url'] = array(
      '#type' => 'textfield',
      '#title' => $this->t('Mercury URL'),
      '#default_value' => $config->get('hg_url') ?: 'hg.gatech.edu',
    );
    // cURL timeout
    $form['hg_curl_timeout'] = array(
      '#type' => 'textfield',
      '#title' => $this->t('cURL timeout'),
      '#default_value' => $config->get('hg_curl_timeout') ?: 10,
    );
    // default text format
    $form['hg_text_format'] = array(
      '#type' => 'select',
      '#options' => $formats,
      '#title' => $this->t('Default text format'),
      '#default_value' => $config->get('hg_text_format') ?: $default_format,
    );
    // bye!
    return $form;
  }
  /**
   * {@inheritdoc}
   */
  public function submitForm(array &$form, FormStateInterface $form_state) {
    $values = $form_state->getValues();
    $this->config('hg_reader.settings')
      ->set('hg_url', $values['hg_url'])
      ->set('hg_curl_timeout', $values['hg_curl_timeout'])
      ->set('hg_text_format', $values['hg_text_format'])
      ->save();
  }
}
