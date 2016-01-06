// view/products/_form
this.products = {
  updateCategory: function() {
    console.log(this, 'here');
    var id = $('#product_category_id').val();
    $('.sizes_container').hide();
    $('#sizes_container_for_' + id).show();
  }
};

$(function() {
  products.updateCategory();
  $('#product_category_id').on('change', products.updateCategory);
});

