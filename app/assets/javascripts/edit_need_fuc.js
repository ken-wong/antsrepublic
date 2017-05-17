(function(){

	$(document).ready(function() {
		_queenModel.init('#need_reference_queen_ids');
		_caseModel.init('#need_reference_product_ids');


		$('.add-case').click(function(){
			$('.hide-box').show();
			$('#case-seach .select2').css('width',"100%");
		})

		$('.tab-vote').click(function(){
			$('#case-bookmark').show();
			$('#chooseCase').hide();
		})

		$('.tab-search').click(function(){
			$('#case-bookmark').hide();
			$('#chooseCase').show();
		})

		$('.close-hide').click(function(){
			$('.hide-box').hide();
		})

		// var ImgLen = $('.test-box').find('img').length;
		// $('.test-box').width(($('.test-box').find('.col-md-1').width()+50)*ImgLen);
		//
		// $('.btn-right').click(function(){
		// 	var box = $('.test-box');
		// 	var nowLeft = box.position().left;
		// 	var width = box.width();
		// 	console.log(nowLeft);
		//
		// 	if(nowLeft>-width){
		// 		box.animate({'left':nowLeft-150+'px'});
		// 	}else {
		// 		box.css('left',10+'px');
		// 	}
		//
		//
		// })
		//
		// $('.btn-left').click(function(){
		// 	var box = $('.test-box');
		// 	var nowLeft = box.position().left;
		// 	console.log(nowLeft);
		// 	if(nowLeft<10){
		// 		box.animate({'left':nowLeft+150+'px'});
		//
		// 	}else {
		// 		box.css('left',10+'px');
		// 	}
		// })
		//


		var caseSelectorOption = {
			selector:$('.caseSelector'),
			placeholder:"请搜索你想作为参考的案例",
			url:"/api/queen_works/search",
			processResultsFuc:function (data, params) {return {results: data.queen_works}},
		}

		var queenSelectorOption = {
			selector:$('.queenSelector'),
			placeholder:"请搜索你想合作的蚁后",
			url:"/api/queens/search",
			processResultsFuc:function (data, params) {return {results: data.queens}},
		}

		setupSelect2(caseSelectorOption);
		setupSelect2(queenSelectorOption);

		$('.add-product').click(function(evt){
			var select_case_id = $(evt.currentTarget).attr("data-id");
			var select_case_img = $(evt.currentTarget).attr("data-img");
			var select_case_title = $(evt.currentTarget).attr("data-title");
			var case_data = {
				avatar_small_url:select_case_img,
				title:select_case_title,
				id:select_case_id
			}
			if(_caseModel.add(select_case_id)){
				addProductToSelectedList(case_data);
			}
		});

		$('.queenSelector').on('select2:select', function (evt) {
			var select_queen_id = evt.params.data.id;
			if(_queenModel.add(select_queen_id)){
				addQueenToSelectedList(evt.params.data);
			}
		});

		$('.caseSelector').on('select2:select', function (evt) {
			var select_case_id = evt.params.data.id;
			if(_caseModel.add(select_case_id)){
				addProductToSelectedList(evt.params.data);
			}
		});

		$("a.queen").click(function(evt){
			$(evt.currentTarget).toggleClass('selected');
		}).find('span.delete_btn').click(removeSelectedUnit);

		$("form.edit_need").on("submit",function(evt){
			$("form.edit_need #need_reference_queen_ids").val(convertAarryToString(_queenModel.data));
			$("form.edit_need #need_reference_product_ids").val(convertAarryToString(_caseModel.data));
		});

	});

	// 参考案例弹出层
	$(function(){
		$('.queenSelector+span').width("97%");
		$('.queenSelector+span').css("margin-left",15+'px');
		var chooseCase=$("div#chooseCase");
		var btnChoose=$("button#sureChoose");
		var addCase=$("span.addCase");
		// chooseCase.hide();
		$("span.addCase,button#sureChoose").click(function(){
			var add=addCase.html();
			if(add=="+")
			{
				// addCase.css("line-height","30px");
				addCase.html("x");
			}
			else{
				// addCase.css("line-height","40px");
				addCase.html("+");
			}
			chooseCase.toggle();
			btnChoose.toggle();
		});
	});

	function setupSelect2(_option){
		_option.selector.select2({
			placeholder:_option.placeholder,
			ajax:{
				url:_option.url,
				method: 'GET',
				dataType: 'json',
				delay: 250,
				data: function(params){return {q: params.term};},
				processResults: _option.processResultsFuc,
				cache: true
			},
			escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
			minimumInputLength: 1,
			templateResult: formatRepo, // omitted for brevity, see the source of this page
			templateSelection: formatRepoSelection // omitted for brevity, see the source of this page
		});
	}

	function addProductToSelectedList(_data){

		var str = '<li class="col-case-and-queen"><span>'+_data.title +'</span> <span class="delete_btn btn" data-id='+_data.id+' data-type="case">x 删除</span></li>'


		console.log(str);
		$('.case-list ul').prepend($(str)).find('.delete_btn').click(removeSelectedUnit);
		// $('body').on('click','.delete_btn',function(){
		// 	removeSelectedUnit();
		// })

		// $('<div class="col-md-1 col-case-and-queen text-center col-case"></div>').append($(str).click(function(evt){
		// 	$(evt.currentTarget).toggleClass('selected');
		// }).find('span.delete_btn').click(removeSelectedUnit).parent()).appendTo('.edit-box');
		// $('.btn-left,.btn-right').show();
		// $('.edit-box').find('.txt-empty').css('display','none');
	}

	function addQueenToSelectedList(_data){

		var str = '      <a class="queen" href="javascript:void(0)">' +
				'          <p>' +
				'          	<img src="'+_data.avatar_small_url+'" >' +
				'          </p>' +
				'          <h6>' +
							_data.name +
				'          </h6>' +
				'			<span class="delete_btn btn" data-id="'+_data.id+'" data-type="queen">' +
				'                X' +
				'           </span>';
				'        </a>';


		$('<div class="col-md-1 col-case-and-queen text-center"></div>').append($(str).click(function(evt){
			$(evt.currentTarget).toggleClass('selected');
		}).find('span.delete_btn').click(removeSelectedUnit).parent()).appendTo('.selected_queen_list');
		$('.btn-left,.btn-right').show();
	}

	function formatRepo (repo) {
		if (repo.loading) return repo.text;

		var _name = repo.title == undefined ? repo.name : repo.title;

		var markup = "<div class='select2-result-repository clearfix'>" +
			"<div class='select2-result-repository__avatar'><img src='" + repo.avatar_small_url + "' /></div>" +
			"<div class='select2-result-repository__meta'>" +
			"<div class='select2-result-repository__title'>" + _name + "</div></div>";

		return markup;
    }

    function formatRepoSelection (repo) {
      return repo.name || repo.text;
    }



    function convertAarryToString(_arr){
    	var str = '[';
    	for(var i=0;i<_arr.length;i++){
    		if(i>0){
    			str += ",";
    		}
    		str += '"'+_arr[i]+'"';
    	}
    	return str+']';
    }

    var removeSelectedUnit = function(evt){
		var _id = $(evt.currentTarget).attr("data-id");
		console.log(_id);
		var isQueen = ($(evt.currentTarget).attr("data-type") == "queen");
		$(evt.currentTarget).parents(".col-case-and-queen").remove();
		if(isQueen){
			_queenModel.del(_id);

			console.log("delete the queen "+_id);
		}else{
			_caseModel.del(_id)
			console.log("delete the case "+_id);
			if($('.col-case').find('img').length==0) {
				$('.edit-box').find('.txt-empty').css('display','block');
			}
		}
	}

    var Model = function(_dom){
    	var _input,_arr;
    	return {
    		init:function(_dom){
    			_input = $(_dom);
    			_arr = _input.val().length>0 ? _input.val().split(',') : [];
    		},
    		add:function(_id){
    			if(_arr.indexOf(_id.toString())<0){
					_arr.push(_id.toString());
					_input.val(_arr.toString());
					return true;
				}else{
					return false
				}
    		},
    		del:function(_id){
    			var idx = _arr.indexOf(_id)
				if(idx > -1){
					_arr.splice(idx,1);
					_input.val(_arr.toString());
				}
    		},
    		data:_arr
    	}
    }

    var _queenModel = new Model();
    var _caseModel = new Model();

}());
