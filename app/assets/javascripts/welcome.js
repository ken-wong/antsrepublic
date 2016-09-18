$(function(){
	$('.homepageCarousel.owl-carousel').owlCarousel({
		stagePadding: 50,
		loop:true,
		margin:10,
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
	});

	// 修改首页的显示效果是ajax查询
	var $productList=$(".product-list-jack");
	$productList.click(function(e){
		e.preventDefault();
		var indexValue=$productList.index(this);
		$productList.removeClass("active_class");
		$productList.eq(indexValue).addClass("active_class");
		$.ajax({
			url:"/api/queen_works.json",
			type:"post",
			data:{category:'效果图'},
			dataType:"json",
			success:function(data){
				alert("success");
			},
			error:function(e){
				console.log(e);
			}
		});
	})

})
