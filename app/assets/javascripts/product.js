this.productForm = {
  showRootCategory: function () {
    var $forms  = $('form.js_product_form'),
        $select = $('select#js_root_category')

    if($forms.length > 1) {
      var categoryId = $select.val();
      var $selectedForm = $('form#js_root_category_' + categoryId);
    } else {
      var $selectedForm = $forms;
    }

    $forms.hide();
    $selectedForm.show();
  },

  showCategory: function() {
    var $form   = $('form.js_product_form'),
        $select = $('select#product_category_id'),
        $sizes  = $('[data-size_category_id]');

    $sizes.hide();
    if($select.val()) {
      $('[data-size_category_id=' + $select.val() + ']').show();
    }
  }
};

$(function() {
  productForm.showRootCategory();
  $('select#js_root_category').on('change', productForm.showRootCategory);

  productForm.showCategory();
  $('select#product_category_id').on('change', productForm.showCategory);
});

