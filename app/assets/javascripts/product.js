this.productForm = {
  update: function () {
    var $forms      = $('form.js_product_form'),
        $select = $('select#js_root_category')

    if($forms.length > 1) {
      var categoryId = $select.val();
      var $selectedForm = $('form#js_root_category_' + categoryId);
    } else {
      var $selectedForm = $forms;
    }

    $forms.hide();
    $selectedForm.show();
  }
};

$(function() {
  productForm.update();
  $('select#js_root_category').on('change', productForm.update);
});

