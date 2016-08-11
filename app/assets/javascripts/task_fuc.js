(function(){
	$(document).ready(function(){
		$('.deadLineDataPicker').datetimepicker({
		    format: 'yyyy-mm-dd',
		    autoclose: true,
		    minView: 2,
		    language: 'zh-CN'
		});

		$('.responsive-calendar').responsiveCalendar({
	        time: '2016-08',
	        events: taskData
	    });	

	    $(".updatePlanBtn").click(function(evt){
	    	var planId = $(evt.currentTarget).attr("data-plan");
	    	var formId = "#plan_f_"+planId;
	    	var PatchData = $(formId).serialize();

	    	var purl = "http://localhost:3000/api/plans/"+planId;
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

	    $(".delPlanBtn").click(function(evt){
	    	var planId = $(evt.currentTarget).attr("data-plan");
	    	var purl = "http://localhost:3000/api/plans/"+planId;

	    	$.ajax({
	    		method:"DELETE",
	    		url:purl	
	    	}).done(function(msg){
	    		$("#plan-unit-"+planId).remove();
	    	});
	    })

	    $(".createPlanBtn").click(function(evt){
	    	var needId = $(evt.currentTarget).attr("data-need");
	    	var formData = $("#create_plan_form").serializeArray();


	    	$.ajax({
	    		method: "POST",
	    		url:"http://localhost:3000/api/needs/"+needId+"/plans",
	    		data: formData
	    	}).done(function(msg){
	    		$("#new-plan-form").toggle();
	    		$(".collapse#new-plan-form").before(createPlanUnit(msg.plan_id,formData[0].value,formData[1].value));
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

	


}());

