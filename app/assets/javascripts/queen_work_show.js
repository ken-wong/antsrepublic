//案例详情页面
(function(){
  $(document).ready(function() {
    var caseVideo = $('#caseVideo')[0];
    var caseVideoEl = $('.queenWorkVideoPlay');



    caseVideo.onmouseover = function(){
      console.log(1)
      $('.queenWorkVideoPlay span').show();
    }

    caseVideo.onmouseout = function(e){

      if(e.pageX<130||e.pageX>1000){
        $('.queenWorkVideoPlay span').hide();
      }
    }

    caseVideo.onended = function(){
    	$('.queenWorkVideoPlay span').addClass('glyphicon-play');
    	$('.queenWorkVideoPlay span').removeClass('glyphicon-pause');
    }
    $('.queenWorkVideoPlay').click(function(e){
    	if(caseVideo.paused){
			caseVideo.play();
			$('.queenWorkVideoPlay span').removeClass('glyphicon-play');
			$('.queenWorkVideoPlay span').addClass('glyphicon-pause');
    	}else{
			caseVideo.pause();
			$('.queenWorkVideoPlay span').addClass('glyphicon-play');
			$('.queenWorkVideoPlay span').removeClass('glyphicon-pause');
    	}
    })
  });

  $('.jiathis').click(function(e){
    e.preventDefault();
    jiathis_sendto('weixin');
    return false
  })

}());
