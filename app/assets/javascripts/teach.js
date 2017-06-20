$(document).ready(function() {
  var page = 1;
  var rulePage = $('.rule-page');
  $('.rule-next-page').on('click',function(){
    if(page<8){
      page++;
      for(var i=0;i<rulePage.length;i++){
        rulePage.eq(i).css('display','none');
      }
      $('body').scrollTop(0);
      $('.page_' + page).css('display','block');
      $('.rule-last-page').css('display','block');
      $('.rule-next-page').css('display','block');
      if(page==8){
        $('.rule-next-page').css('display','none');
      }
    }
  })

  $('.rule-last-page').on('click',function(){
    if(page>1){
      page--;
      for(var i=0;i<rulePage.length;i++){
        rulePage.eq(i).css('display','none');
      }
      $('body').scrollTop(0);
      $('.page_' + page).css('display','block');
      $('.rule-last-page').css('display','block');
      $('.rule-next-page').css('display','block');
      if(page==1){
        $('.rule-last-page').css('display','none');
      }
    }
  })

  
});
