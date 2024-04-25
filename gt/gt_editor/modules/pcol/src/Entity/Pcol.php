<?php

namespace Drupal\pcol\Entity;

use Drupal\Core\Entity\EntityStorageInterface;
use Drupal\Core\Field\BaseFieldDefinition;
use Drupal\Core\Entity\ContentEntityBase;
use Drupal\Core\Entity\EntityTypeInterface;
use Drupal\Core\Entity\EntityChangedTrait;
use Drupal\datetime\Plugin\Field\FieldType\DateTimeItem;
use Drupal\pcol\PcolInterface;
use Drupal\user\UserInterface;
use \Drupal\node\Entity\Node;
use \Drupal\file\Entity\File;
use \Drupal\taxonomy\Entity\Term;
use Drupal\Core\Database\Connection;
use Drupal\Core\Messenger\MessengerTrait;
use Drupal\Core\File\FileSystemInterface;

/**
 * Defines the Pcol entity. Each pcol consists of a rich text field and a column
 * size selector. Columns are, furthermore, fieldable, so we got that going for us.
 *
 * @ingroup pcol
 *
 * @ContentEntityType(
 *   id = "pcol",
 *   label = @Translation("Paragraph column entity"),
 *   handlers = {
 *     "view_builder" = "Drupal\Core\Entity\EntityViewBuilder",
 *     "list_builder" = "Drupal\pcol\Entity\Controller\PcolListBuilder",
 *     "views_data" = "Drupal\views\EntityViewsData",
 *     "form" = {
 *       "add" = "Drupal\pcol\Form\PcolForm",
 *       "edit" = "Drupal\pcol\Form\PcolForm",
 *       "delete" = "Drupal\pcol\Form\PcolDeleteForm",
 *     },
 *     "access" = "Drupal\pcol\PcolAccessControlHandler",
 *   },
 *   base_table = "entity_pcol",
 *   admin_permission = "administer pcol entity",
 *   fieldable = TRUE,
 *   entity_keys = {
 *     "id" = "id",
 *     "uuid" = "uuid"
 *   },
 *   links = {
 *     "canonical" = "/admin/structure/pcols/{pcol}",
 *     "edit-form" = "/admin/structure/pcols/{pcol}/edit",
 *     "delete-form" = "/admin/structure/pcols/{pcol}/delete",
 *     "collection" = "/admin/structure/pcols/list"
 *   },
 * )
 *
 */
class Pcol extends ContentEntityBase implements PcolInterface {

  use EntityChangedTrait; // Implements methods defined by EntityChangedInterface.
  use MessengerTrait;

  /**
   * {@inheritdoc}
   *
   */
  public static function preCreate(EntityStorageInterface $storage_controller, array &$values) {
    parent::preCreate($storage_controller, $values);
    $values += array(
      'user_id' => \Drupal::currentUser()->id(),
    );
  }

  /**
   * {@inheritdoc}
   */
  public function getCreatedTime() {
    return $this->get('created')->value;
  }

  /**
   * {@inheritdoc}
   */
  public function getOwner() {
    return $this->get('user_id')->entity;
  }

  /**
   * {@inheritdoc}
   */
  public function getOwnerId() {
    return $this->get('user_id')->target_id;
  }

  /**
   * {@inheritdoc}
   */
  public function setOwnerId($uid) {
    $this->set('user_id', $uid);
    return $this;
  }

  /**
   * {@inheritdoc}
   */
  public function setOwner(UserInterface $account) {
    $this->set('user_id', $account->id());
    return $this;
  }

  /**
   * {@inheritdoc}
   *
   */
  public static function baseFieldDefinitions(EntityTypeInterface $entity_type) {

    # ID
    $fields['id'] = BaseFieldDefinition::create('integer')
      ->setLabel(t('ID'))
      ->setDescription(t('The ID of the pcol.'))
      ->setReadOnly(TRUE);


    # UUID
    $fields['uuid'] = BaseFieldDefinition::create('uuid')
      ->setLabel(t('UUID'))
      ->setDescription(t('The UUID of the pcol.'))
      ->setReadOnly(TRUE);


    # Body
    $fields['body'] = BaseFieldDefinition::create('text_long')
      ->setLabel(t('Body'))
      ->setRequired(FALSE)
      ->setDisplayOptions('view', array(
        'label' => 'hidden',
        'type' => 'text_textarea',
        'weight' => -6,
      ))
      ->setDisplayOptions('form', array(
        'type' => 'default',
        'weight' => -6,
      ))
      ->setDisplayConfigurable('form', TRUE)
      ->setDisplayConfigurable('view', TRUE);


    # Column width large
    $fields['col_large'] = BaseFieldDefinition::create('integer')
      ->setLabel(t('Column width large'))
      ->setSetting('min', 0)
      ->setSetting('max', 12)
      ->setRequired(TRUE)
      ->setDefaultValue(8)
      ->setDisplayOptions('view', array(
        'label' => 'above',
        'type' => 'hidden',
        'weight' => -6,
        'region' => 'hidden'
      ))
      ->setDisplayOptions('form', array(
        'type' => 'default',
        'weight' => -6,
      ))
      ->setDisplayConfigurable('form', TRUE)
      ->setDisplayConfigurable('view', TRUE);


    # Column width medium
    $fields['col_medium'] = BaseFieldDefinition::create('integer')
      ->setLabel(t('Column width medium'))
      ->setSetting('min', 0)
      ->setSetting('max', 12)
      ->setRequired(TRUE)
      ->setDefaultValue(8)
      ->setDisplayOptions('view', array(
        'label' => 'above',
        'type' => 'hidden',
        'weight' => -6,
        'region' => 'hidden'
      ))
      ->setDisplayOptions('form', array(
        'type' => 'default',
        'weight' => -6,
      ))
      ->setDisplayConfigurable('form', TRUE)
      ->setDisplayConfigurable('view', TRUE);


    # Column width small
    $fields['col_small'] = BaseFieldDefinition::create('integer')
      ->setLabel(t('Column width small'))
      ->setSetting('min', 0)
      ->setSetting('max', 12)
      ->setRequired(TRUE)
      ->setDefaultValue(12)
      ->setDisplayOptions('view', array(
        'label' => 'above',
        'type' => 'hidden',
        'weight' => -6,
        'region' => 'hidden'
      ))
      ->setDisplayOptions('form', array(
        'type' => 'default',
        'weight' => -6,
      ))
      ->setDisplayConfigurable('form', TRUE)
      ->setDisplayConfigurable('view', TRUE);


    # User ID
    $fields['user_id'] = BaseFieldDefinition::create('entity_reference')
      ->setLabel(t('Author'))
      ->setDescription(t('The entity author.'))
      ->setRequired(TRUE)
      ->setSetting('target_type', 'user')
      ->setSetting('handler', 'default')
      ->setDisplayOptions('form', array(
        'type' => 'entity_reference_autocomplete',
        'settings' => array(
          'match_operator' => 'CONTAINS',
          'size' => 60,
          'placeholder' => '',
        ),
        'weight' => -3,
      ))
      ->setDisplayOptions('view', array(
        'label' => 'above',
        'type' => 'hidden',
        'weight' => -3,
        'region' => 'hidden'
      ))
      ->setDisplayOptions('form', array(
        'type' => 'hidden',
        'weight' => -6,
      ))
      ->setDisplayConfigurable('form', TRUE)
      ->setDisplayConfigurable('view', TRUE);


    # Langcode
    $fields['langcode'] = BaseFieldDefinition::create('language')
      ->setLabel(t('Language code'))
      ->setDescription(t('The language code of Paragraph columns entity.'));

    # Created
    $fields['created'] = BaseFieldDefinition::create('created')
      ->setLabel(t('Created'))
      ->setDescription(t('The time that the entity was created.'));

    # Changed
    $fields['changed'] = BaseFieldDefinition::create('changed')
      ->setLabel(t('Changed'))
      ->setDescription(t('The time that the entity was last edited.'));

    return $fields;
  }
}
