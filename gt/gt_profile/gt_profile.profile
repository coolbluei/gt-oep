<?php

/**
 * Implements hook_form_FORM_ID_alter() for install_configure_form().
 * Allows the profile to alter the site configuration form.
 */

function gt_profile_form_install_configure_form_alter(&$form, $form_state) {
  $form['admin_account']['account']['name']['#default_value'] = 'root';
  $form['regional_settings']['site_default_country']['#default_value'] = 'US';
}
