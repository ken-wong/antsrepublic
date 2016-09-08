$(function(){
	$('.homepageCarousel.owl-carousel').owlCarousel({
		stagePadding: 300,
		loop:true,
		margin:50,
		nav:true,
		dots:true,
		navText:['<','>'],
		responsive:{
	        0:{
	            items:1
	        }
	    }
	});

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
	})

})
