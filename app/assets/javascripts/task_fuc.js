(function(){
	$(document).ready(function(){
		$('.responsive-calendar').responsiveCalendar({
	        time: '2016-08',
	        events: taskData
	    });	

	    $(".updateTaskBtn").click(function(evt){
	    	var taskId = $(evt.currentTarget).attr("data-task");
	    	var formId = "#task_f_"+taskId;
	    	var PatchData = $(formId).serialize();

	    	var purl = "http://localhost:3000/api/tasks/"+taskId;
	    	// console.log(PatchData);
	    	$.ajax({
	    		method:"PATCH",
	    		url:purl,
	    		data:PatchData
	    	}).done(function(msg){
	    		var taskObj = msg.task;
	    		var output = $("#task-unit-"+taskObj.id+" .task-output")
	    		output.find("span.task-time").html(taskObj.dead_line);
	    		output.find("span.task-title").html(taskObj.title);
	    		toggleTaskEdit(taskObj.id);
	    	});
	    });

	    $(".delTaskBtn").click(function(evt){
	    	var taskId = $(evt.currentTarget).attr("data-task");
	    	var purl = "http://localhost:3000/api/tasks/"+taskId;

	    	$.ajax({
	    		method:"DELETE",
	    		url:purl	
	    	}).done(function(msg){
	    		$("#task-unit-"+taskId).remove();
	    	});
	    })

	    $(".createTaskBtn").click(function(evt){
	    	var needId = $(evt.currentTarget).attr("data-need");
	    	var formData = $("#create_task_form").serializeArray();


	    	$.ajax({
	    		method: "POST",
	    		url:"http://localhost:3000/api/needs/"+needId+"/tasks",
	    		data: formData
	    	}).done(function(msg){
	    		$("#new-task-form").toggle();
	    		$(".collapse#new-task-form").before(createTaskUnit(msg.task_id,formData[0].value,formData[1].value));
	    	});
	    })

	    $(".editTaskBtn").click(function(evt){
	    	var taskId = $(evt.currentTarget).attr("data-task");
	    	toggleTaskEdit(taskId);

	    });

	    $(".cancleUpdateTaskBtn").click(function(evt){
	    	var taskId = $(evt.currentTarget).attr("data-task");
	    	toggleTaskEdit(taskId);
	    })
	})

	var toggleTaskEdit = function(taskId){
		$("#task-unit-"+taskId+" .task-output").toggleClass("hidden");
	    $("#task-unit-"+taskId+" .task-input").toggleClass("hidden");
	}

	var createTaskUnit = function(_taskId, _time, _title){
		return "	<div class='task-unit' id='task-unit-"+_taskId+"'>" +
					"  <div class='task-output'>" +
					"    <span class='task-time'>"+_time+"</span>" +
					"    <span class='task-title'>"+_title+"</span>" +
					"    <span class='task-action'>" +
					"      <a class='editTaskBtn' data-task='"+_taskId+"' href='javascript:void(0)'>编辑</a>" +
					"      <a class='delTaskBtn' data-task='"+_taskId+"' href='javascript:void(0)'>删除</a>" +
					"    </span>" +
					"  </div>" +
					"  <div class='task-input hidden'>" +
					"    <form id='task_f_"+_taskId+"'>" +
					"      <span class='task-time'>" +
					"        <input type='text' name='task[dead_line]' value='"+_time+"'>" +
					"      </span>" +
					"      <span class='task-title'>" +
					"        <input type='text' name='task[title]' value='"+_title+"'>" +
					"      </span>" +
					"      <span class='task-action'>" +
					"        <a class='updateTaskBtn' data-task='"+_taskId+"' href='javascript:void(0)'>保存</a>" +
					"        <a class='cancleUpdateTaskBtn' data-task='"+_taskId+"' href='javascript:void(0)'>取消</a>" +
					"      </span>" +
					"    </form>" +
					"  </div>" +
					"</div>";
	}

	


}());

