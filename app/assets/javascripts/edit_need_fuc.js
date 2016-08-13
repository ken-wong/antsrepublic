(function(){
	$(document).ready(function() {
		var queen_ids_arr = new Array(eval($("#need_reference_queen_ids").val()));

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

		$(".queenSelector").select2({
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
		});
	});


	function formatRepo (repo) {
		if (repo.loading) return repo.text;

		var markup = "<div class='select2-result-repository clearfix'>" +
			"<div class='select2-result-repository__avatar'><img src='" + repo.avatar_small_url + "' /></div>" +
			"<div class='select2-result-repository__meta'>" +
			"<div class='select2-result-repository__title'>" + repo.name + "</div></div>";

		return markup;
    }

    function formatRepoSelection (repo) {
      return repo.name || repo.text;
    }

}());
