(function(){
	
	$(document).ready(function() {
		_queenModel.init('#need_reference_queen_ids');
		_caseModel.init('#need_reference_product_ids');

		var caseSelectorOption = {
			selector:$('.caseSelector'),
			placeholder:"请搜索你想作为参考的案例",
			url:"http://localhost:3000/api/queen_works/search",
			processResultsFuc:function (data, params) {return {results: data.queen_works}},
		}

		var queenSelectorOption = {
			selector:$('.queenSelector'),
			placeholder:"请搜索你想合作的蚁后",
			url:"http://localhost:3000/api/queens/search",
			processResultsFuc:function (data, params) {return {results: data.queens}},
		}

		setupSelect2(caseSelectorOption);
		setupSelect2(queenSelectorOption);
		
		$('.queenSelector').on('select2:select', function (evt) {
			var select_queen_id = evt.params.data.id;
			_queenModel.add(select_queen_id);
			addQueenToSelectedList(evt.params.data);
		});

		$('.caseSelector').on('select2:select', function (evt) {
			var select_case_id = evt.params.data.id;
			_caseModel.add(select_case_id);
			addProductToSelectedList(evt.params.data);
		});

		$("a.queen").click(function(evt){
			$(evt.currentTarget).toggleClass('selected');
		}).find('span.delete_btn').click(removeSelectedUnit);

		$("form.edit_need").on("submit",function(evt){
			$("form.edit_need #need_reference_queen_ids").val(convertAarryToString(_queenModel.data));
			$("form.edit_need #need_reference_product_ids").val(convertAarryToString(_caseModel.data));
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

		var str = '      <a class="queen" href="javascript:void(0)" data-case="'+_data.id+'">' +
				'          <p>' +
				'          	<img src="'+_data.avatar_small_url+'" class="img-circle">' +
				'          </p>' +
				'          <h6>' +
							_data.title +
				'          </h6>' +
				'			<span class="delete_btn btn" data-id="'+_data.id+'" data-type="case">' +
				'                删除' +
				'           </span>';
				'        </a>' ;

		$('<div class="col-md-2 text-center"></div>').append($(str).click(function(evt){
			$(evt.currentTarget).toggleClass('selected');
		}).find('span.delete_btn').click(removeSelectedUnit).parent()).appendTo('.selected_case_list');
	}

	function addQueenToSelectedList(_data){

		var str = '      <a class="queen" href="javascript:void(0)">' +
				'          <p>' +
				'          	<img src="'+_data.avatar_small_url+'" class="img-circle">' +
				'          </p>' +
				'          <h6>' +
							_data.name +
				'          </h6>' +
				'			<span class="delete_btn btn" data-id="'+_data.id+'" data-type="queen">' +
				'                删除' +
				'           </span>';
				'        </a>';


		$('<div class="col-md-2 text-center"></div>').append($(str).click(function(evt){
			$(evt.currentTarget).toggleClass('selected');
		}).find('span.delete_btn').click(removeSelectedUnit).parent()).appendTo('.selected_queen_list');
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
		var isQueen = ($(evt.currentTarget).attr("data-type") == "queen");
		$(evt.currentTarget).parents(".queen").remove();
		if(isQueen){
			_queenModel.del(_id);
			console.log("delete the queen "+_id);
		}else{
			_caseModel.del(_id)
			console.log("delete the case "+_id);
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
    			if(_arr.indexOf(_id)<0){
					_arr.push(_id.toString());
					_input.val(_arr.toString());
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
