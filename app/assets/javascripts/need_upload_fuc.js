$(function(){
  $('.need_img_upload').fileupload({
    dataType: 'script',
    submit: function(e, data) {
    },
    add: function(e, data) {
      data.submit(e, data);
    },
  });
})
