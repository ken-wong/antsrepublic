$(function(){
  $('.need_img_upload').fileupload({
    dataType: 'script',
    submit: function(e, data) {
       $('.img_list').prepend('<div class="uploading">上传中</div>')
    },
    progressall: function (e, data) {
      var progress = parseInt(data.loaded / data.total * 100, 10);
      $('.uploading').html(progress+"%");
      if(progress == 100){
        $('.uploading').html('等待服务器处理，请勿刷新页面');
      }
    },
    add: function(e, data) {
      data.submit(e, data);
    },
  });
})

// $('.attachment_file_upload').fileupload({
//       dataType: 'json',
//       submit: function(e, data){
//         // $('.fileupload-buttonbar').toggleClass('active');
//         var id = data.form.attr("id");
//         id = id.split('-')[1];
//         $('#plan_task_' + id + ' .task-result-files ul').prepend('<li class="uploading"><a>上传中</a></li>')
//       },
//       progressall: function (e, data) {
//         var progress = parseInt(data.loaded / data.total * 100, 10);
//         $('.task-result-files li.uploading>a').html(progress+"%");
//         if(progress == 100){
//           $('.task-result-files li.uploading>a').html('等待服务器处理，请勿刷新页面');
//         }
//       },
//       done: function (e, data) {
//         var obj = data.result;
//         $('.task-result-files li.uploading').remove();
//     $('#plan_task_'+obj.attachmentable_id+" .task-result-files ul").prepend('<li class="text-center"><span>'+
//       '<a href="' + obj.file_url  + '">'+
//         obj.file_name+
//       '</a></span></li>')
//        window.location.reload();
//       }
//   });
