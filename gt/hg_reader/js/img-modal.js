(function ($, Drupal) {
    Drupal.behaviors.img_modal = {
      attach: function (context, settings) {
        return // code needs to be refactored to account for the hg_media field
        // Get the modal
        var modal = document.querySelector("#modal");

        // Get the image and insert it inside the modal - use its "alt" text as a caption
        var img = document.querySelectorAll("img");
        var modalImg = document.getElementById("modal-image");
        var captionText = document.getElementById("caption");

        for(var i=0;i<img.length;i++){
            img[i].onclick = function(){
                modal.style.display = "flex";
                modalImg.src = this.src;
                captionText.innerHTML = this.alt;
            }
        }
        // img.onclick = function(){
        //     modal.style.display = "flex";
        //     modalImg.src = this.src;
        //     captionText.innerHTML = this.alt;
        // }

        // Get the <span> element that closes the modal
        var span = document.getElementsByClassName("close")[0];

        // When the user clicks on <span> (x), close the modal
        modal.onclick = function() {
        modal.style.display = "none";
}
      }
    };
  })(jQuery, Drupal);

