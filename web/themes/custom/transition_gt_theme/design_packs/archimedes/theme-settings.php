<?php
/**
 * Implementation of hook_form_system_theme_settings_alter()
 *
 * @param $form
 *   Nested array of form elements that comprise the form.
 *
 * @param $form_state
 *   A keyed array containing the current state of the form.
 */
function archimedes_form_system_theme_settings_alter(&$form, &$form_state) {
    $form['core'] = array(
        '#type' => 'vertical_tabs',
        '#attributes' => array('class' => array('entity-meta')),
        '#weight' => -899
    );

    $form['theme_settings']['#group'] = 'core';
    $form['logo']['#group'] = 'core';
    $form['favicon']['#group'] = 'core';

    $form['theme_settings']['#open'] = FALSE;
    $form['logo']['#open'] = FALSE;
    $form['favicon']['#open'] = FALSE;

    // Custom settings in Vertical Tabs container
    $form['options'] = array(
        '#type' => 'vertical_tabs',
        '#attributes' => array('class' => array('entity-meta')),
        '#weight' => -999,
        '#default_tab' => 'edit-variables',
        '#states' => array(
            'invisible' => array(
                ':input[name="force_subtheme_creation"]' => array('checked' => TRUE),
            ),
        ),
    );
  /*--------- Setting Header ------------ */
  $form['general'] = array(
    '#type' => 'details',
    '#attributes' => array(),
    '#title' => t('Header Options'),
    '#weight' => -999,
    '#group' => 'options',
    '#open' => FALSE,
  );

  // Set up the select to include/not include
  $form['general']['sticky_menu'] =array(
    '#type' => 'select',
    '#title' => t('Enable Sticky Menu'),
    '#default_value' => theme_get_setting('sticky_menu'),
    '#group' => 'general',
    '#options' => array(
      '0'        => t('Disable'),
      '1'        => t('Enable')
    )
  );

  // Set up the select to include/not include
  $form['general']['sticky_header'] =array(
    '#type' => 'select',
    '#title' => t('Enable Sticky Header'),
    '#default_value' => theme_get_setting('sticky_header'),
    '#group' => 'general',
    '#options' => array(
      '0'        => t('Disable'),
      '1'        => t('Enable')
    )
  );

  // Set up the select to include/not include // HIDE DEMI-HEADER UNTIL OFFICIALLY APPROVED FOR CAMPUS WIDE USE

  /** $form['general']['demi_header'] =array(
    '#type' => 'select',
    '#title' => t('Enable Demi Header'),
    '#default_value' => theme_get_setting('demi_header'),
    '#group' => 'general',
    '#options' => array(
      '0'        => t('Disable'),
      '1'        => t('Enable')
    )
  );
**/

  /*--------- Setting SuperFooter ------------ */
  $form['footer_settings'] = array(
    '#type'         => 'details',
    '#title'        => t('Superfooter Options'),
    '#description'  => t('Configure options'),
    '#weight' => -997,
    '#group' => 'options',
    '#open' => TRUE,
  );

  // Set up the checkbox to include/not include
  $form['footer_settings']['super_footer'] = array(
    '#type'         => 'checkbox',
    '#title'        => t('Show SuperFooter'),
    '#default_value' => theme_get_setting('super_footer'),
    '#description'  => t('Check this option if you\'d like to show the SuperFooter.'),
    '#options' => array(
      '0'        => t('Disable'),
      '1'        => t('Enable'),
    ),
  );

  /*--------- Setting Footer ------------ */
  $form['footer'] = array(
    '#type' => 'details',
    '#attributes' => array(),
    '#title' => t('Footer options'),
    '#weight' => -998,
    '#group' => 'options',
    '#open' => FALSE,
  );

  // Set up the select to include/not include
  $form['footer']['footer_fixed'] = array(
    '#type' => 'select',
    '#title' => t('Setting Footer Fixed'),
    '#default_value' => theme_get_setting('footer_fixed'),
    '#group' => 'footer',
    '#options' => array(
      ''              => t('Disable'),
      'footer-fixed'  => t('Enable'),
    ),
  );

  // Dynamic Bootstrap columns for superfooter
  $form['footer']['footer_first_size'] = array(
    '#type' => 'select',
    '#title' => t('Footer First Size'),
    '#default_value' => theme_get_setting('footer_first_size') ? theme_get_setting('footer_first_size') : 3,
    '#options' => array('Default', 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 , 11, 12),
    '#description' => 'Setting width for grid bootstrap / 12'
  );

  $form['footer']['footer_second_size'] = array(
    '#type' => 'select',
    '#title' => t('Footer Second Size'),
    '#default_value' => theme_get_setting('footer_second_size') ? theme_get_setting('footer_second_size') : 3,
    '#options' => array('Default', 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 , 11, 12),
    '#description' => 'Setting width for grid bootstrap / 12'
  );

  $form['footer']['footer_third_size'] = array(
    '#type' => 'select',
    '#title' => t('Footer Third Size'),
    '#default_value' => theme_get_setting('footer_third_size') ? theme_get_setting('footer_third_size') : 3,
    '#options' => array('Default', 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 , 11, 12),
    '#description' => 'Setting width for grid bootstrap / 12'
  );

  $form['footer']['footer_four_size'] = array(
    '#type' => 'select',
    '#title' => t('Footer Four Size'),
    '#default_value' => theme_get_setting('footer_four_size') ? theme_get_setting('footer_four_size') : 3,
    '#options' => array('Default', 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 , 11, 12),
    '#description' => 'Setting width for grid bootstrap / 12'
  );

  /*--------- User CSS ------------ */
  $form['options']['css_customize'] = array(
    '#type' => 'details',
    '#attributes' => array(),
    '#title' => t('Customize css'),
    '#weight' => -996,
    '#group' => 'options',
    '#open' => TRUE,
  );

  // Set up textarea for custom css
  $form['customize']['customize_css'] = array(
    '#type' => 'textarea',
    '#title' => t('Add your own CSS'),
    '#group' => 'css_customize',
    '#attributes' => array('class' => array('code_css') ),
    '#default_value' => theme_get_setting('customize_css'),
  );

  // Save on submit
  $form['actions']['submit']['#value'] = t('Save');

}


