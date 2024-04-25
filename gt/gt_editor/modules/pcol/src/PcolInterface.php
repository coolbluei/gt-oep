<?php

namespace Drupal\pcol;

use Drupal\Core\Entity\ContentEntityInterface;
use Drupal\user\EntityOwnerInterface;
use Drupal\Core\Entity\EntityChangedInterface;

/**
 * Provides an interface defining a paragraph column entity.
 * @ingroup whistle
 */
interface PcolInterface extends ContentEntityInterface, EntityOwnerInterface, EntityChangedInterface {

}
