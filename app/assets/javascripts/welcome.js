$(function(){
    $.scrollUp({
    	scrollDistance: 600,
    	scrollText: '返回顶部'
    });


    $(document).ready(function($) {

		var newopt={
			w2:"180",//小图宽度
			h2:"180"//小图高度
		};

		i_slide($(".container_image"),newopt);

		$('.homepageCarousel.owl-carousel').owlCarousel({
      autoplay: 3,
			dots:true,
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

    $('.owl-carousel.partner-carousel').owlCarousel({
			loop:false,
			margin:10,
			nav:true,
			dots:false,
      autoPlay: true,
			navText:[' ',' '],
			responsive:{
		        0:{
		            items:3
		        }
		    }
		});


    $('.owl-carousel.ants-carousel').owlCarousel({
			loop:false,
			margin:10,
			nav:true,
			dots:false,
			navText:[' ',' '],
			responsive:{
		        0:{
		            items:3
		        }
		    }
		});

    });


	// 修改首页的案例显示效果是ajax查询
	var $productList=$(".product-list-jack");
	$productList.click(function(e){
		e.preventDefault();
		var indexValue=$productList.index(this);
		$productList.removeClass("active_class");
		$productList.eq(indexValue).addClass("active_class");
		$.ajax({
			url:"/api/queen_works.json",
			type:"GET",
			data:{category:$productList.eq(indexValue).html()},
			dataType:"json",
			success:function(data){
				console.log(data.queen_works);
				$("div.owl-stage").css({
					"width":"100%",
					"min-height":"550px",
					"line-height":"550px",
					"transform": "translate3d(0px, 0px, 0px)",
				});
				if(data.queen_works.length){
					$("div.owl-stage").html("");
					for (var i = 0; i< data.queen_works.length; i++) {
						 var str='<div class="owl-item active" style="width: 458.333px; margin-right: 10px;"><div class="item">'
	            				+'<div class="product">'
	              					+'<div class="productBlock">'
	              						+'<a href="/queen_works/1">'
	                						+'<div class="product-image" style="background-image:url('+data.queen_works[i].avatar_small_url+')">'
	                						+'</div>'
	    								+'</a>'
	                					+'<div class="caption bordered">'
		                  					+'<h3>'
		                    					+'<a href="/queen_works/1">'+data.queen_works[i].title+'</a>'
		                  					+'</h3>'
		                  					+'<div class="description">'
			                    				+'<p>'
			                        				+'<b>委托客户:</b>'+data.queen_works[i].client_name
			                    				+'</p>'
			                    				+'<p>'
			                        				+'<b>参考价格:</b>'+data.queen_works[i].ref_price
			                    				+'</p>'
			                    				+'<p>'
			                      					+'<span class="glyphicon glyphicon-heart"></span>'
			                      					+'<span>0</span>'
			                      					+'<span class="glyphicon glyphicon-share"></span>'
			                      					+'<span>0</span>'
			                    				+'</p>'
		                  					+'</div>'
	                					+'</div>'
	              					+'</div>'
	            				+'</div>'
	            			+'</div>';
	            		$("div.owl-stage").append(str);
					}
					$(".owl-prev,.owl-next").show();
				}else{
					$("div.owl-stage").css({
					"text-align":"center"
				});
					$(".owl-prev,.owl-next").hide();
					$("div.owl-stage").html("该类型的案例还是路上哦！！");
				}
			},
			error:function(e){
				console.log(e);
			}
		});
	});

  var scrollHeight = $('.homepageCarousel').height();
  window.onscroll = function(){
    var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
    if(scrollTop>=scrollHeight) {
      $('.topNav').css('background-color','rgba(255,255,255,0.9)');
      $('.a_border').css('color','#000');
      $('.a_border').addClass('border_black');
      $('.a_noborder').css('color','#000');
      $('.no_login').css('color','#000');
      $('.nav.navbar-nav li').css('color','#000');
      $('.nav.navbar-nav li a').css('color','#000');
      $('.no_login .old').hide();
      $('.no_login .new').show();
    }else{
      $('.topNav').css('background-color','transparent');
      $('.a_border').css('color','#fff');
      $('.a_border').removeClass('border_black');
      $('.a_noborder').css('color','#fff');
      $('.no_login').css('color','#fff');
      $('.nav.navbar-nav li').css('color','#fff');
      $('.nav.navbar-nav li a').css('color','#fff');
      $('.no_login .old').show();
      $('.no_login .new').hide();
    }
  }

});
