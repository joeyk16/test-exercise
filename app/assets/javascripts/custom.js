// view/products/_form
$(function() {
  $('.sizes_container').hide();
  $('#product_category_id').on('change', function(){
    $('.sizes_container input').hide();
    $('.sizes_container input').removeAttr('checked');

    $('#sizes_container_for_' + $(this).val()).show();
  })
});

