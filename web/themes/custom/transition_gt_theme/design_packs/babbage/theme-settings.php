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
function babbage_form_system_theme_settings_alter(&$form, &$form_state)
{
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
        '#weight' => -1001,
        '#default_tab' => 'edit-variables',
        '#states' => array(
            'invisible' => array(
                ':input[name="force_subtheme_creation"]' => array('checked' => TRUE),
            ),
        ),
    );

    /*--------- Footer Contact Info ------------ */
    $form['footer_contact'] = array(
        '#type'         => 'details',
        '#title'        => t('Contact Info'),
        '#description'  => t('Contact information is displayed in the footer'),
        '#weight'       => -1000,
        '#open'         => TRUE,
    );

    // Contact Title
    $form['footer_contact']['contact_title'] = array(
        '#type'           => 'textfield',
        '#title'          => t('Title'),
        '#description'    => t('Title will appear above Georgia Institute of Technology'),
        '#default_value'  => theme_get_setting('contact_title'),
    );

    // Address
    $form['footer_contact']['contact_address'] = array(
        '#type'           => 'textfield',
        '#title'          => t('Address'),
        '#description'    => t('Address'),
        '#default_value'  => theme_get_setting('contact_address'),
    );

    // Address (2)
    $form['footer_contact']['contact_address_2'] = array(
        '#type'           => 'textfield',
        '#title'          => t('Address Line Two'),
        '#description'    => t('Address (2)'),
        '#default_value'  => theme_get_setting('contact_address_2'),
    );

    // City
    $form['footer_contact']['contact_city'] = array(
        '#type'           => 'textfield',
        '#title'          => t('City'),
        '#description'    => t('Add your city'),
        '#default_value'  => theme_get_setting('contact_city'),
    );


    // State
    $form['footer_contact']['contact_state'] = array(
        '#type'           => 'textfield',
        '#title'          => t('State'),
        '#description'    => t('Add Your State'),
        '#default_value'  => theme_get_setting('contact_state'),
    );


    // Zip Code
    $form['footer_contact']['contact_zip_code'] = array(
        '#type'           => 'textfield',
        '#title'          => t('Zip Code'),
        '#description'    => t('Add your Zip Code'),
        '#default_value'  => theme_get_setting('contact_zip_code'),
    );

    // Telephone Number
    $form['footer_contact']['contact_telephone'] = array(
        '#type'           => 'tel',
        '#title'          => t('Telephone Number'),
        '#description'    => t('Accepted formats: 404.894.2000 or (404) 894-2000 or 404-894-2000'),
        '#default_value'  => theme_get_setting('contact_telephone'),
    );

    // Map URL
    $form['footer_contact']['contact_map_url'] = array(
        '#type'           => 'textfield',
        '#title'          => t('Map URL'),
        '#description'    => t('Add custom link to the address'),
        '#default_value'  => theme_get_setting('contact_map_url'),
    );

    /*--------- Setting Site Layout ------------ */
    $form['site_settings'] = array(
        '#type' => 'details',
        '#attributes' => array(),
        '#title' => t('Content width options'),
        '#weight' => -999,
        '#group' => 'options',
        '#open' => FALSE,
    );

    // Set up the select to include/not include
    $form['site_settings']['site_layout'] = array(
        '#type' => 'select',
        '#title' => t('Body Layout'),
        '#default_value' => theme_get_setting('site_layout'),
        '#description' => t('Select Wide (100%) or Boxed (1170px)'),
        '#options' => array(
            '0' => t('Boxed (default)'),
            '1' => t('Wide'),
        ),
    );

    /*--------- SettingCAS Login ------------ */
    $form['page_setting'] = array(
        '#type' => 'details',
        '#attributes' => array(),
        '#title' => t('GT(CAS) login options'),
        '#weight' => -998,
        '#group' => 'options',
        '#open' => FALSE,
    );

    /*--------- Setting CAS Login ------------ */
    // Set up the select to include/not include
    $form['page_setting']['cas_login'] = array(
        '#type' => 'select',
        '#title' => t('Enable GT(CAS) Login'),
        '#default_value' => theme_get_setting('cas_login'),
        '#group' => 'general',
        '#options' => array(
            '0' => t('Enable'),
            '1' => t('Disable')
        )
    );

    /*--------- Setting Header ------------ */
    $form['general'] = array(
        '#type' => 'details',
        '#attributes' => array(),
        '#title' => t('Header options'),
        '#weight' => -997,
        '#group' => 'options',
        '#open' => FALSE,
    );

    /*--------- Setting Sticky Menu ------------ */
    // Set up the select to include/not include
    $form['general']['sticky_menu'] = array(
        '#type' => 'select',
        '#title' => t('Enable Sticky Menu'),
        '#default_value' => theme_get_setting('sticky_menu'),
        '#description' => t('Enable this option to stick menu to top on scroll.'),
        '#group' => 'general',
        '#options' => array(
            '0' => t('Disable'),
            '1' => t('Enable')
        )
    );

    /*--------- Setting Sticky Header ------------ */
    // Set up the select to include/not include
    $form['general']['sticky_header'] = array(
        '#type' => 'select',
        '#title' => t('Enable Sticky Header'),
        '#default_value' => theme_get_setting('sticky_header'),
        '#description' => t('Enable this option to fix header at top.'),
        '#group' => 'general',
        '#options' => array(
            '0' => t('Disable'),
            '1' => t('Enable')
        )
    );

    /*--------- Setting Demi-Header ------------ */
    // Set up the select to include/not include
    $form['general']['demi_header'] = array(
        '#type' => 'select',
        '#title' => t('Enable Demi Header'),
        '#default_value' => theme_get_setting('demi_header'),
        '#group' => 'general',
        '#options' => array(
            '0' => t('Disable'),
            '1' => t('Enable')
        )
    );


    /*--------- Setting Breadcrumb ------------ */
    $form['page_settings'] = array(
        '#type' => 'details',
        '#title' => t('Breadcrumb options'),
        '#description' => t('Configure options'),
        '#weight' => -996,
        '#group' => 'options',
        '#open' => TRUE,
    );

    // Set up the checkbox to include/not include
    $form['page_settings']['hide_breadcrumb'] = array(
        '#type' => 'checkbox',
        '#title' => t('Hide breadcrumbs'),
        '#default_value' => theme_get_setting('hide_breadcrumb'),
        '#description' => t('Check this option if you\'d like to hide the breadcrumbs system wide.'),
        '#options' => array(
            '0' => t('Disable'),
            '1' => t('Enable'),
        ),
    );


    /*--------- Setting Footer ------------ */
    $form['footer'] = array(
        '#type' => 'details',
        '#attributes' => array(),
        '#title' => t('Footer options'),
        '#weight' => -994,
        '#group' => 'options',
        '#open' => FALSE,
    );

    // Set up the select to include/not include Fixed Footer
    $form['footer']['footer_fixed'] = array(
        '#type' => 'select',
        '#title' => t('Setting Footer Fixed'),
        '#default_value' => theme_get_setting('footer_fixed'),
        '#description' => t('Check this option if you\'d like to fix footer to bottom.'),
        '#group' => 'footer',
        '#options' => array(
            '' => t('Disable'),
            'footer-fixed' => t('Enable'),
        ),
    );

    /*--------- Setting SuperFooter ------------ */
    $form['footer_settings'] = array(
        '#type' => 'details',
        '#title' => t('Superfooter options'),
        '#description' => t('Configure options'),
        '#weight' => -993,
        '#group' => 'options',
        '#open' => TRUE,
    );

    // Set up the checkbox to include/not include
    $form['footer_settings']['super_footer'] = array(
        '#type' => 'checkbox',
        '#title' => t('Show SuperFooter'),
        '#default_value' => theme_get_setting('super_footer'),
        '#description' => t('Check this option if you\'d like to show the SuperFooter.'),
        '#options' => array(
            '0' => t('Disable'),
            '1' => t('Enable'),
        ),
    );

    /*--------- Setting SuperFooter ------------ */

    // Dynamic Bootstrap columns for superfooter
    $form['footer']['footer_first_size'] = array(
        '#type' => 'select',
        '#title' => t('Footer First Size'),
        '#default_value' => theme_get_setting('footer_first_size') ? theme_get_setting('footer_first_size') : 3,
        '#options' => array('Default', 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12),
        '#description' => 'Setting width for grid bootstrap / 12'
    );

    $form['footer']['footer_second_size'] = array(
        '#type' => 'select',
        '#title' => t('Footer Second Size'),
        '#default_value' => theme_get_setting('footer_second_size') ? theme_get_setting('footer_second_size') : 3,
        '#options' => array('Default', 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12),
        '#description' => 'Setting width for grid bootstrap / 12'
    );

    $form['footer']['footer_third_size'] = array(
        '#type' => 'select',
        '#title' => t('Footer Third Size'),
        '#default_value' => theme_get_setting('footer_third_size') ? theme_get_setting('footer_third_size') : 3,
        '#options' => array('Default', 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12),
        '#description' => 'Setting width for grid bootstrap / 12'
    );

    $form['footer']['footer_four_size'] = array(
        '#type' => 'select',
        '#title' => t('Footer Four Size'),
        '#default_value' => theme_get_setting('footer_four_size') ? theme_get_setting('footer_four_size') : 3,
        '#options' => array('Default', 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12),
        '#description' => 'Setting width for grid bootstrap / 12'
    );

    /*--------- Setting Custom CSS ------------ */

    $form['options']['css_customize'] = array(
        '#type' => 'details',
        '#attributes' => array(),
        '#title' => t('Customize css'),
        '#weight' => -992,
        '#group' => 'options',
        '#open' => TRUE,
    );

    // Set up textarea for custom css
    $form['customize']['customize_css'] = array(
        '#type' => 'textarea',
        '#title' => t('Add your own CSS'),
        '#group' => 'css_customize',
        '#attributes' => array('class' => array('code_css')),
        '#default_value' => theme_get_setting('customize_css'),
    );

    // Save on submit
    $form['actions']['submit']['#value'] = t('Save');

}


