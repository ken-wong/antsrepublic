(function(){
	$(document).ready(function(){
		$('.products_section .category_dropdown_menu a').click(function(e){
			var category = $(this).data('category');
			$('#q_category_eq').val(category);
			$('#queen_work_search .dropdown-toggle').html(category+'<span class="caret"></span>');
			$(this).parents('.input-group-btn').removeClass('open');
			return false;
		});

		$('.search-btn').click(function(){
			console.log(1)
			$('.queen_work_search').submit();
		})
	})

}())
