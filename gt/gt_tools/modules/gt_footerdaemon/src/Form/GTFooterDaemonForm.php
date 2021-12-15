<?php

namespace Drupal\gt_footerdaemon\Form;

use Drupal\Core\Form\ConfigFormBase;
use Drupal\Core\Form\FormStateInterface;

/**
* Puts the lime in the coconut.
*/
class GTFooterDaemonForm extends ConfigFormBase {

  /**
  * {@inheritdoc}
  */
  public function getFormId() {
    return 'gt_footerdaemon_settings_form';
  }

  /**
  * {@inheritdoc}
  */
  protected function getEditableConfigNames() {
    return [
      'gt_footerdaemon.settings',
    ];
  }

  /**
  * {@inheritdoc}
  */
  public function buildForm(array $form, FormStateInterface $form_state) {
    $form = parent::buildForm($form, $form_state);

    $config = $this->config('gt_footerdaemon.settings');

    $form['data_source'] = array(
      '#type' => 'textfield',
      '#title' => t('Footer data source'),
      '#default_value' => $config->get('data_source'),
      '#required' => TRUE,
    );

    return parent::buildForm($form, $form_state);
  }

  /**
  * {@inheritdoc}
  */
  public function validateForm(array &$form, FormStateInterface $form_state) {
  }

  /**
  * {@inheritdoc}
  */
  public function submitForm(array &$form, FormStateInterface $form_state) {
    $config = $this->config('gt_footerdaemon.settings');
    $config->set('data_source', $form_state->getValue('data_source'));
    $config->save();
    return parent::submitForm($form, $form_state);
  }

}
