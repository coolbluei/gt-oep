<?php
/**
 * @file
 */

namespace Drupal\gt_tools\Plugin\Block;

use Drupal\Core\Block\BlockBase;

/**
 * Provides a block to display the footer logo info.
 *
 * @Block(
 *   id = "gt_footer_logo_block",
 *   admin_label = @Translation("GT footer logo block")
 * )
 */
class GTFooterLogoBlock extends BlockBase {
  public function build() {
    return [
      '#theme' => 'gt_footer_logo',
    ];
  }
}
