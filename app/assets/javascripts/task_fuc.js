(function(){
	var scoreSpeed,
		scoreQuality,
		scoreService = 0;
	$(document).ready(function(){

		//获取项目的评分情况
		$.ajax({
			method:'GET',
			url:'/api/needs/' + need_id + '/vote_sum',
		}).done(function(data){
			if(data.vote_speed && parseInt(data.vote_speed) > 0){
				//有评分，显示分数
				$('.vote_sum_block').toggle();
				$('.vote_sum_block span.vote_speed_num').html(buildVoteNumIcons(data.vote_speed));
				$('.vote_sum_block span.vote_quality_num').html(buildVoteNumIcons(data.vote_quality));
				$('.vote_sum_block span.vote_service_num').html(buildVoteNumIcons(data.vote_service));
			}else{
				//没有评分，如果是甲方，则显示打分，如果是乙方，则不显示
				$('.vote_block').show();
			}
		})

		//打分模块
		$('.task-vote .vote_block span.score').mouseover(function(e){
			var child = $(e.currentTarget);
			var parent = child.parent('.vote_num_selector');
			var index = child.index();
			makeStar(parent, index);
		}).click(function(e){
			var child = $(e.currentTarget);
			var parent = child.parent('.vote_num_selector');
			var index = child.index();
			var typeId = parent.attr('id');
			switch(typeId){
				case 'scoreSpeed':
					scoreSpeed = index+1;
					break;
				case 'scoreQuality':
					scoreQuality = index+1;
					break;
				case 'scoreService':
					scoreService = index+1;
					break;

			}

			makeStar(parent, index);
		});

		$(".vote_num_selector").mouseout(function(e){
			var dom = $(e.currentTarget)
			var typeId = dom.attr('id');
			var index = -1
			switch(typeId){
				case 'scoreSpeed':
					index = scoreSpeed;
					break;
				case 'scoreQuality':
					index = scoreQuality;
					break;
				case 'scoreService':
					index = scoreService;
					break;
			}

			makeStar(dom, index-1);

		});

		$('.submitVote').click(function(e){
			$(this).hide();
			$.post('/api/needs/'+need_id+'/vote_to_me',{
				voter_id:user_id,
				speedStars:scoreSpeed,
				qualityStars:scoreQuality,
				serviceStars:scoreService
			},function(data){
				$('.vote_block').hide();
				$('.vote_sum_block').show();
				$('.vote_sum_block span.vote_speed_num').html(buildVoteNumIcons(data.vote_speed));
				$('.vote_sum_block span.vote_quality_num').html(buildVoteNumIcons(data.vote_quality));
				$('.vote_sum_block span.vote_service_num').html(buildVoteNumIcons(data.vote_service));
			})
		})

		//文件上传
		$('.attachment_file_upload').fileupload({
	        dataType: 'json',
	        submit: function(e, data){
	          // $('.fileupload-buttonbar').toggleClass('active');
	          var id = data.form.attr("id");
	          id = id.split('-')[1];
	          $('#plan_task_' + id + ' .task-result-files ul').prepend('<li class="uploading"><a>上传中</a></li>')
	        },
	        progressall: function (e, data) {
	          var progress = parseInt(data.loaded / data.total * 100, 10);
	          $('.task-result-files li.uploading>a').html(progress+"%");
	          if(progress == 100){
		          $('.task-result-files li.uploading>a').html('等待服务器处理，请勿刷新页面');
	          }
	        },
	        done: function (e, data) {
	        	var obj = data.result;
	        	$('.task-result-files li.uploading').remove();
				$('#plan_task_'+obj.attachmentable_id+" .task-result-files ul").prepend('<li class="text-center"><span>'+
					'<a href="' + obj.file_url  + '">'+
					'<img src="' + obj.file_url + '?imageView2/1/w/200/h/200">'+
					'</a></span></li>')
				console.log();
	        }
	    });

		//设置计划弹窗中的日期选择
		$('.deadLineDataPicker').datetimepicker({
		    format: 'yyyy-mm-dd',
		    autoclose: true,
		    minView: 2,
		    language: 'zh-CN'
		});


		//点击日历事件方法
		function addTask(el) {
			var div = '<div class="plan-mask"><span>任务名称</span><span class="task-input"><input type="text"></span><span class="task-btn"></span></div>';
			el.prepend(div);
		}

		//提交任务方法
		function commitTask(date){
			$('body').on('click','.task-btn',function(){
				var needId = $('.need-id').attr('need_id');
				var planTitle = $('.task-input input').val();
				$.ajax({
					method: "POST",
					url:"/api/needs/"+needId+"/plans",
					data:{
						plan:{dead_line:date,title:planTitle},
						need_id:needId
					},
					success:function(res){
						console.log(res);
						window.location.reload();
					}
				});
			})
		}


		//日历
		$('.responsive-calendar').responsiveCalendar({
	        time: firstTaskData,
	        events: taskData,
					onDayClick: function(events) {
						var thisDayEvent, key;
			      key = $(this).data('year')+'-'+ $(this).data('month') +'-'+ $(this).data('day') ;
			      // thisDayEvent = events[key];
			      // alert(thisDayEvent.number);
						$('.plan-mask').remove();
						addTask($(this).parent());
						commitTask(key);
					}
	    });

		//设置计划弹窗中的修改任务（task）按钮
	    $(".updatePlanBtn").click(function(evt){
	    	var planId = $(evt.currentTarget).attr("data-plan");
	    	var formId = "#plan_f_"+planId;
	    	var PatchData = $(formId).serialize();

	    	var purl = "/api/plans/"+planId;
	    	// console.log(PatchData);
	    	$.ajax({
	    		method:"PATCH",
	    		url:purl,
	    		data:PatchData
	    	}).done(function(msg){
	    		var planObj = msg.plan;
	    		var output = $("#plan-unit-"+planObj.id+" .plan-output")
	    		output.find("span.plan-time").html(planObj.dead_line);
	    		output.find("span.plan-title").html(planObj.title);
	    		togglePlanEdit(planObj.id);
	    	});
	    });

	    //设置计划弹窗中的删除任务（task）按钮
	    $(".delPlanBtn").click(function(evt){
	    	var planId = $(evt.currentTarget).attr("data-plan");
	    	var purl = "/api/plans/"+planId;

	    	$.ajax({
	    		method:"DELETE",
	    		url:purl
	    	}).done(function(msg){
	    		$("#plan-unit-"+planId).remove();
	    	});
	    })

	    //设置计划弹窗中的创建任务（task）按钮
	    $(".createPlanBtn").click(function(evt){
	    	var needId = $(evt.currentTarget).attr("data-need");
	    	var formData = $("#create_plan_form").serializeArray();


	    	$.ajax({
	    		method: "POST",
	    		url:"/api/needs/"+needId+"/plans",
	    		data: formData
	    	}).done(function(msg){
	    		$(".collapse#new-plan-form").before(createPlanUnit(msg.plan_id,formData[0].value,formData[1].value));
	    		$(".collapse#new-plan-form").collapse('toggle');
	    	});
	    })

	    $(".editPlanBtn").click(function(evt){
	    	var planId = $(evt.currentTarget).attr("data-plan");
	    	togglePlanEdit(planId);

	    });

	    $(".cancleUpdateplanBtn").click(function(evt){
	    	var planId = $(evt.currentTarget).attr("data-plan");
	    	togglePlanEdit(planId);
	    })
	})

	var togglePlanEdit = function(planId){
		$("#plan-unit-"+planId+" .plan-output").toggleClass("hidden");
	    $("#plan-unit-"+planId+" .plan-input").toggleClass("hidden");
	}

	var createPlanUnit = function(_planId, _time, _title){
		return "	<div class='plan-unit' id='plan-unit-"+_planId+"'>" +
					"  <div class='plan-output'>" +
					"    <span class='plan-time'>"+_time+"</span>" +
					"    <span class='plan-title'>"+_title+"</span>" +
					"    <span class='plan-action'>" +
					"      <a class='editplanBtn' data-plan='"+_planId+"' href='javascript:void(0)'>编辑</a>" +
					"      <a class='delplanBtn' data-plan='"+_planId+"' href='javascript:void(0)'>删除</a>" +
					"    </span>" +
					"  </div>" +
					"  <div class='plan-input hidden'>" +
					"    <form id='plan_f_"+_planId+"'>" +
					"      <span class='plan-time'>" +
					"		<div class='form-group'>" +
					"        <input class='form-control deadLineDataPicker' type='text' name='plan[dead_line]' placeholder='请选择日期' readonly value='"+_time+"'>" +
					"		</div>" +
					"      </span>" +
					"      <span class='plan-title'>" +
					"		<div class='form-group'>" +
					"        <input class='form-control' type='text' name='plan[title]' value='"+_title+"'>" +
					"		</div>" +
					"      </span>" +
					"      <span class='plan-action'>" +
					"        <a class='updateplanBtn' data-plan='"+_planId+"' href='javascript:void(0)'>保存</a>" +
					"        <a class='cancleUpdateplanBtn' data-plan='"+_planId+"' href='javascript:void(0)'>取消</a>" +
					"      </span>" +
					"    </form>" +
					"  </div>" +
					"</div>";
	}

	var buildVoteNumIcons = function(_num){
		var _html = '';
		for(i=0;i<_num;i++){
			_html += '<span class="score"></span>';
		}
		return $(_html)
	}

	var makeStar = function(_parentDom, _index){
		_parentDom.find('span.score').removeClass('hover');
		if(_index>=0){
			_parentDom.find('.score:lt(' + (_index+1) + ')').addClass('hover');

		}
	}


}());
