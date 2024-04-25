(function ($, Drupal) {
    Drupal.behaviors.videoplayer = {
      attach: function (context, settings) {

        var slideIndex = 1;

        showSlides(slideIndex);
        
        function plusSlides(n) {
          showSlides(slideIndex += n);
        }
        
        function currentSlide(n) {
          showSlides(slideIndex = n);
        }
       
        function showSlides(n) {
          var i;
          var slides = document.getElementsByClassName("video-embed-field-provider-youtube");
          if (n > slides.length) {slideIndex = 1}
          if (n < 1) {slideIndex = slides.length}
          for (i = 0; i < slides.length; i++) {
              slides[i].style.display = "none";
          }
         
          slides[slideIndex-1].style.display = "block";

        }
        document.querySelector('.prev').addEventListener('click', evt=> {
          plusSlides(-1)
        })

        document.querySelector('.next').addEventListener('click', evt =>{
          plusSlides(1)
        })
      }
    };
  })(jQuery, Drupal);
  