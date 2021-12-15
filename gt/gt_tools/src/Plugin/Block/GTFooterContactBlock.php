<?php
/**
 * @file
 */

namespace Drupal\gt_tools\Plugin\Block;

use Drupal\Core\Block\BlockBase;

/**
 * Provides a block to display the GT footer contact info.
 *
 * @Block(
 *   id = "gt_footer_contact_block",
 *   admin_label = @Translation("GT footer contact block")
 * )
 */
class GTFooterContactBlock extends BlockBase {
  public function build() {
    return [
      '#theme' => 'gt_footer_contact',
    ];
  }
}
