$(function(){
  $('.need_img_upload').fileupload({
    submit: function(e, data) {
    },
    add: function(e, data) {
      console.log(data);
    }
  });
})
