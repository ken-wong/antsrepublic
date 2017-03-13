$(document).ready(function() {
    $('.case-carousel.owl-carousel').owlCarousel({
      loop:false,
      margin:10,
      nav:true,
      dots:false,
      navText:['<','>'],
      responsive:{
            0:{
                items:3
            }
        }
    });
  });
