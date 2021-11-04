/* Sticky footer */
(function ($) {
  "use strict";
  (function ($) {
    // Footer fixed
    var footerFixed = function() {
      var footer_height = $('#footer').height();
      $('body.footer-fixed .gt-body-page').css('margin-bottom', footer_height);
    }

    $(document).ready(function(){
      footerFixed();
    });

    $(window).on("debouncedresize", function(event) {
      footerFixed();
    });

  })(jQuery);
})(jQuery);