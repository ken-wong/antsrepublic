//案例详情页面
(function(){
  $(document).ready(function() {
    var caseVideo = $('#caseVideo')[0];
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

}());