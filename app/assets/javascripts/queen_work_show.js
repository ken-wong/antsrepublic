//案例详情页面
(function(){
  $(document).ready(function() {
    var caseVideo = $('#caseVideo')[0];
    // var caseVideoEl = $('.queenWorkVideoPlay');

    var casePlayer = videojs('caseVideo');
    casePlayer.ready(function(){
      // myPlayer.play();
    });

    // caseVideo.onmouseover = function(){
    //   $('.queenWorkVideoPlay span').show();
    // }

    // caseVideo.onmouseout = function(e){

    //   if(e.pageX<130||e.pageX>1000){
    //     $('.queenWorkVideoPlay span').hide();
    //   }
    // }

    // caseVideo.onended = function(){
    // 	$('.queenWorkVideoPlay span').addClass('glyphicon-play');
    // 	$('.queenWorkVideoPlay span').removeClass('glyphicon-pause');
    // }

    // $('.queenWorkVideoPlay').click(function(e){
    // 	if(myPlayer.paused()){
			 //   myPlayer.play();
			 //   $('.queenWorkVideoPlay span').removeClass('glyphicon-play');
			 //   $('.queenWorkVideoPlay span').addClass('glyphicon-pause');
    // 	}else{
			 //   myPlayer.pause();
			 //   $('.queenWorkVideoPlay span').addClass('glyphicon-play');
			 //   $('.queenWorkVideoPlay span').removeClass('glyphicon-pause');
    // 	}
    // })
  });

  

  

}());
