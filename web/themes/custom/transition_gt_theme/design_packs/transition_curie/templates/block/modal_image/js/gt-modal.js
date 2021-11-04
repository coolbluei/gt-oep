(function ($, Drupal) {
  Drupal.behaviors.gt_modal = {
    attach: function (context, settings) {
      // Initialize tooltip component
      $('[data-toggle="tooltip"]').tooltip();
      // Initialize popover component
      $('[data-toggle="popover"]').popover();
      // Stop video on window close
      $('.modal').on('hide.bs.modal', function() {
        var memory = $(this).html();
        $(this).html(memory);
      });
    }
  }
})(jQuery, Drupal);
