(function(){
	$(document).ready(function() {

		var queen_ids_arr;
		if($('#need_reference_queen_ids').size() > 0){
			queen_ids_arr = $("#need_reference_queen_ids").val().split(',');
		}else{
			queen_ids_arr = [];
		}
		 

		var addQueen = function(_id){
			if(queen_ids_arr.indexOf(_id)<0){
				queen_ids_arr.push(_id);
				$("#need_reference_queen_ids").val(queen_ids_arr.toString());
			}
			// return queen_ids_arr
		}

		var delQueen = function(_id){
			var idx = queen_ids_arr.indexOf(_id)
			if(idx > -1){
				queen_ids_arr.splice(idx,1);
				$("#need_reference_queen_ids").val(queen_ids_arr.toString());
			}
		}

		$('.caseSelector').select2({
			placeholder:"请搜索你想作为参考的案例",
			ajax:{
				url:"http://localhost:3000/api/queen_works/search",
				method: 'GET',
				dataType: 'json',
				delay: 250,
				data: function(params){
					return {
						q: params.term,
					};
				},
				processResults: function (data, params) {
					// parse the results into the format expected by Select2
					// since we are using custom formatting functions we do not need to
					// alter the remote JSON data, except to indicate that infinite
					// scrolling can be used
					// params.page = params.page || 1;
					return {
						results: data.queen_works,
						// pagination: {
						// 	more: (params.page * 30) < data.total_count
						// }
					};
				},
				cache: true
			},
			escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
			minimumInputLength: 1,
			templateResult: formatRepo2, // omitted for brevity, see the source of this page
			templateSelection: formatRepoSelection // omitted for brevity, see the source of this page
		});

		$(".queenSelector").select2({
			placeholder:"请搜索你想合作的蚁后",
			ajax: {
			    url: "http://localhost:3000/api/queens/search",
			    method: 'GET',
			    dataType: 'json',
			    delay: 250,
			    data: function (params) {
			      return {
			        q: params.term, // search term
			      };
			    },
			    processResults: function (data, params) {
					// parse the results into the format expected by Select2
					// since we are using custom formatting functions we do not need to
					// alter the remote JSON data, except to indicate that infinite
					// scrolling can be used
					// params.page = params.page || 1;

					return {
						results: data.queens,
						// pagination: {
						// 	more: (params.page * 30) < data.total_count
						// }
					};
				},
				cache: true
			},
			escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
			minimumInputLength: 1,
			templateResult: formatRepo, // omitted for brevity, see the source of this page
			templateSelection: formatRepoSelection // omitted for brevity, see the source of this page
		});
		
		$('.queenSelector').on('select2:select', function (evt) {
			var select_queen_id = evt.params.data.id;
			addQueen(select_queen_id);
			addQueenToSelectedList(evt.params.data);
		});

		$('.caseSelector').on('select2:select', function (evt) {
			var select_case_id = evt.params.data.id;
			// addQueen(select_queen_id);
			// addQueenToSelectedList(evt.params.data);
		});

		$("a.queen").click(function(evt){
			$(evt.currentTarget).toggleClass('selected');
		})

		$("a.queen span.delete_btn").click(function(evt){
			var qid = $(evt.currentTarget).attr("data-queen");
			console.log("delete the queen "+qid);
			$(evt.currentTarget).parents(".queen").remove();
			delQueen(qid);
		})

		$("form.edit_need").on("submit",function(evt){
			$("form.edit_need #need_reference_queen_ids").val(convertAarryToString(queen_ids_arr));
		});
	});

	function addQueenToSelectedList(_data){

		var str = '		<div class="col-md-2 text-center">' +
				'        <a class="queen" href="javascript:void(0)" data-queen="'+_data.id+'">' +
				'          <p>' +
				'          	<img src="'+_data.avatar_small_url+'" class="img-circle">' +
				'          </p>' +
				'          <h6>' +
							_data.name +
				'          </h6>' +
				'        </a>' +
				'      </div>';
		$('.selected_queen_list').append($(str));
	}


	function formatRepo (repo) {
		if (repo.loading) return repo.text;

		var markup = "<div class='select2-result-repository clearfix'>" +
			"<div class='select2-result-repository__avatar'><img src='" + repo.avatar_small_url + "' /></div>" +
			"<div class='select2-result-repository__meta'>" +
			"<div class='select2-result-repository__title'>" + repo.name + "</div></div>";

		return markup;
    }

    function formatRepo2 (repo) {
		if (repo.loading) return repo.text;

		var markup = "<div class='select2-result-repository clearfix'>" +
			"<div class='select2-result-repository__avatar'><img src='" + repo.avatar_small_url + "' /></div>" +
			"<div class='select2-result-repository__meta'>" +
			"<div class='select2-result-repository__title'>" + repo.title + "</div></div>";

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

}());
