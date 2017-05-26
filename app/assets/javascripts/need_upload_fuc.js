$(function(){
  $('.need_img_upload').fileupload({
    dataType: 'script',
    submit: function(e, data) {
       $('.img_list').prepend('<div class="uploading">上传中</div>')
    },
    add: function(e, data) {
      data.submit(e, data);
    },
  });
})
