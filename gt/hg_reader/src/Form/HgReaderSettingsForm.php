<?php

namespace Drupal\hg_reader\Form;

use Drupal\Core\Form\ConfigFormBase;
use Drupal\Core\Form\FormStateInterface;
use Drupal\hg_reader\Entity\HgImporter;
use Drupal\Core\Messenger\MessengerTrait;

/**
 * Defines a form that configures forms module settings.
 */
class HgReaderSettingsForm extends ConfigFormBase {
  use MessengerTrait;

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

    // The associated Mercury group(s) for this site.
    $form['hg_group'] = array(
      '#type' => 'select',
      '#title' => $this->t('Associated Mercury Group(s)'),
      '#options' => $this->getGroups(),
      '#multiple' => TRUE,
      '#size' => 10,
      '#default_value' => $config->get('hg_group') ?: array(0),
      '#attached' => array(
        'library' => array('hg_reader/hg_reader', 'hg_reader/fastselect')
        // 'drupalSettings']['hg_reader'] = $settings;
      )
    );
    array_unshift($form['hg_group']['#options'], '-- No group --');

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
    return parent::buildForm($form, $form_state);
  }

  public function getGroups() {
    // Get the groups list from Mercury
    $config = \Drupal::config('hg_reader.settings');
    $hg_url = $config->get('hg_url');
    $url = $hg_url . '/ajax/groupsdata';
    $ch = HgImporter::curl_setup($url);
    $data['data'] = curl_exec($ch);

    if (curl_errno($ch)) {
      $error = curl_error($ch);
    }

    if (!isset($error)) {
      $groups = json_decode($data['data']);
      foreach ($groups as &$group) {
        $group = $group->title;
      }
      sort($groups);
      return $groups;
    } else {
      $this->getLogger('hg_reader')->error('Unable to retrieve groups list from Mercury: %error',
        array(
          '%error' => $error,
        )
      );
      \Drupal::messenger()->addError($this->t('Mercury Reader failed to retrieve the groups list from Mercury. You may need to reinstall the module in order to avoid attenuated functionality.'));
      return array();
    }
  }

  /**
   * {@inheritdoc}
   */
  public function validateForm(array &$form, FormStateInterface $form_state) {
    // if (empty($form_state->getValue('hg_group'))) {
    //   $form_state->setErrorByName('hg_group', $this->t('You must select a group or groups or "-- No group --"'));
    // }
  }

  /**
   * {@inheritdoc}
   */
  public function submitForm(array &$form, FormStateInterface $form_state) {
    $values = $form_state->getValues();
    $this->config('hg_reader.settings')
      ->set('hg_group', $values['hg_group'])
      ->set('hg_url', $values['hg_url'])
      ->set('hg_curl_timeout', $values['hg_curl_timeout'])
      ->set('hg_text_format', $values['hg_text_format'])
      ->save();

    \Drupal::messenger()->addMessage($this->t('Changes saved.'));
  }

}
