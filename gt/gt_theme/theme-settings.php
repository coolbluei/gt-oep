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
function gt_form_system_theme_settings_alter(&$form, &$form_state)
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

  /*--------- GT Intro ------------ */

  $form['options']['gt'] = array(
    '#type' => 'details',
    '#attributes' => array(),
    '#title' => t('Georgia Tech GT theme package'),
    '#description' => t('<p>Georgia Tech Institute Communications-approved basic branding.</p>'),
    '#weight' => -1000,
    '#group' => 'options',
    '#open' => TRUE,
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
        '#description'    => t('Add custom link to the address. Full URL expected: https://goo.gl/maps/5Wbkst47GXA4Wqom6'),
        '#default_value'  => theme_get_setting('contact_map_url'),
    );

    /*--------- Setting CAS Login ------------ */
    $form['page_setting'] = array(
        '#type' => 'details',
        '#attributes' => array(),
        '#title' => t('GT login (CAS)'),
        '#weight' => -998,
        '#group' => 'options',
        '#open' => FALSE,
    );

    /*--------- Setting CAS Login ------------ */
    // Set up the select to include/not include
    $form['page_setting']['cas_login'] = array(
        '#type' => 'select',
				'#title' => t('Enable GT (CAS) Login'),
				'#description' => t('Site login and authentication using your Georgia Tech account and password.'),
        '#default_value' => theme_get_setting('cas_login'),
        '#group' => 'general',
        '#options' => array(
            '1' => t('Enable'),
            '0' => t('Disable')
        )
    );

    /*--------- Setting Header ------------ */
    $form['general'] = array(
        '#type' => 'details',
        '#attributes' => array(),
				'#title' => t('Header options'),
				'#description' => t('Configuration options for the Georgia Tech header and site title and slogan.'),
        '#weight' => -997,
        '#group' => 'options',
        '#open' => FALSE,
    );

    // Title One URL
    $form['general']['title_one_url'] = array(
        '#type'           => 'textfield',
        '#title'          => t('Site Name URL'),
        '#description'    => t('Link the header site title to a URL. Supports a full URL (e.g. https://theme.gatech.edu) or the front page (/).'),
        '#default_value'  => theme_get_setting('title_one_url'),
    );

    // Title Two URL
    $form['general']['title_two_url'] = array(
        '#type'           => 'textfield',
        '#title'          => t('Site Slogan URL'),
        '#description'    => t('Link the header site slogan to a URL. Supports a full URL (e.g. https://theme.gatech.edu) or the front page (/).'),
        '#default_value'  => theme_get_setting('title_two_url'),
    );

    /*--------- Setting Breadcrumb ------------ */
    $form['page_settings'] = array(
        '#type' => 'details',
        '#title' => t('Breadcrumbs'),
        '#description' => t('Configuration options for Breadcrumbs under the menu, which show the navigation from the home page to the current page.'),
        '#weight' => -996,
        '#group' => 'options',
        '#open' => TRUE,
    );

    // Set up the checkbox to include/not include
    $form['page_settings']['hide_breadcrumb'] = array(
        '#type' => 'checkbox',
        '#title' => t('Disable breadcrumbs'),
        '#default_value' => theme_get_setting('hide_breadcrumb'),
        '#description' => t('Remove the breadcrumb links below the main menu'),
        '#options' => array(
            '0' => t('Disable'),
            '1' => t('Enable'),
        ),
    );

    /*--------- Setting SuperFooter ------------ */
    $form['footer_settings'] = array(
        '#type' => 'details',
        '#title' => t('SuperFooter'),
        '#description' => t('By default, the SuperFooter is pre-populated by four columns of links to Georgia Tech websites, but the content can be customized'),
        '#weight' => -993,
        '#group' => 'options',
        '#open' => TRUE,
    );

    // Set up the checkbox to include/not include
    $form['footer_settings']['super_footer'] = array(
        '#type' => 'checkbox',
        '#title' => t('Enable SuperFooter'),
        '#default_value' => theme_get_setting('super_footer'),
        '#description' => t('By default, the SuperFooter is pre-populated by four columns of links to GT websites, but the content can be customized'),
        '#options' => array(
            '0' => t('Disable'),
            '1' => t('Enable'),
        ),
    );

    /*--------- Setting SuperFooter ------------ */

    // Dynamic Bootstrap columns for superfooter
    $form['footer_settings']['footer_01_size'] = array(
        '#type' => 'select',
        '#title' => t('First Column Size'),
        '#default_value' => theme_get_setting('footer_01_size') ? theme_get_setting('footer_01_size') : 3,
        '#options' => array('Default', 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12),
        '#description' => 'Set the width of the SuperFooter column width. Default value is 3. Uses grid bootstrap / 12.'
    );

    $form['footer_settings']['footer_02_size'] = array(
        '#type' => 'select',
        '#title' => t('Second Column Size'),
        '#default_value' => theme_get_setting('footer_02_size') ? theme_get_setting('footer_02_size') : 3,
        '#options' => array('Default', 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12),
        '#description' => 'Set the width of the SuperFooter column width. Default value is 3. Uses grid bootstrap / 12.'
    );

    $form['footer_settings']['footer_03_size'] = array(
        '#type' => 'select',
        '#title' => t('Third Column Size'),
        '#default_value' => theme_get_setting('footer_03_size') ? theme_get_setting('footer_03_size') : 3,
        '#options' => array('Default', 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12),
        '#description' => 'Set the width of the SuperFooter column width. Default value is 3. Uses grid bootstrap / 12.'
    );

    $form['footer_settings']['footer_04_size'] = array(
        '#type' => 'select',
        '#title' => t('Fourth Column Size'),
        '#default_value' => theme_get_setting('footer_04_size') ? theme_get_setting('footer_04_size') : 3,
        '#options' => array('Default', 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12),
        '#description' => 'Set the width of the SuperFooter column width. Default value is 3. Uses grid bootstrap / 12.'
    );

    /*--------- Setting Custom CSS ------------ */

    $form['options']['css_customize'] = array(
        '#type' => 'details',
        '#attributes' => array(),
        '#title' => t('Custom CSS'),
        '#weight' => -992,
        '#group' => 'options',
        '#open' => TRUE,
    );

    // Set up textarea for custom css
    $form['customize']['customize_css'] = array(
        '#type' => 'textarea',
        '#title' => t('Custom CSS'),
        '#group' => 'css_customize',
        '#attributes' => array('class' => array('code_css')),
				'#default_value' => theme_get_setting('customize_css'),
				'#description' => 'Add site-specific custom CSS.'
    );

    // Save on submit
    $form['actions']['submit']['#value'] = t('Save');

}
