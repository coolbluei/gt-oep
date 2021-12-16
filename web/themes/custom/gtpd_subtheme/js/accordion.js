(function ($, Drupal) {

    /**
     * Use this behavior as a template for custom Javascript.
     */
    Drupal.behaviors.accordion = {
      attach: function (context, settings) {
        $('.accordion').accordion({
            collapsible: true,
            heightStyle: "content"
          });
      }
    };
})(jQuery, Drupal);