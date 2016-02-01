this.productForm = {
  update: function () {
    var categoryId = $('select#js_root_category').val();

    $('form.js_product_form').hide();
    $('form#js_root_category_' + categoryId).show();
  }
};

$(function() {
  productForm.update();
  $('select#js_root_category').on('change', productForm.update);
});

