(function(){
	$(document).ready(function(){
		$('.products_section .dropdown-menu a').click(function(e){
			var category = $(e.currentTarget).attr('data-category')
			$('#queen_work_category').val(category);
		});
		$('.products_section #submitSearch').click(function(e){
			$('.products_section form').submit();
		})
	})
	
}())
