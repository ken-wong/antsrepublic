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
	    	var formData = $("#create_task_form").serialize();

	    	$.ajax({
	    		method: "POST",
	    		url:"http://localhost/api/needs//tasks"
	    	}).done(function(msg){

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

}());

