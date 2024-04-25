<?php

namespace Drupal\hg_reader;

use Drupal\Core\Entity\ContentEntityInterface;
use Drupal\user\EntityOwnerInterface;
use Drupal\Core\Entity\EntityChangedInterface;

/**
 * Provides an interface defining a HgImporter entity.
 * @ingroup hg_reader
 */
interface HgImporterInterface extends ContentEntityInterface, EntityOwnerInterface, EntityChangedInterface {

}
