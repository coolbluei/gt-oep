(function ($, Drupal) {
  Drupal.behaviors.gt_modal = {
    attach: function (context, settings) {
      if ($('[data-bs-toggle="tooltip"]').length > 0) {
        // Initialize tooltip component
        $('[data-bs-toggle="tooltip"]').tooltip();
      }
      if ($('[data-bs-toggle="popover"]').length > 0) {
        // Initialize popover component
        $('[data-bs-toggle="popover"]').popover();
      }
      // Stop video on window close
      $('.modal').on('hide.bs.modal', function() {
        var memory = $(this).html();
        $(this).html(memory);
      });
    }
  }
})(jQuery, Drupal);
