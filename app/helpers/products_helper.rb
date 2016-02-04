module ProductsHelper
  def children_categories_allowed_for(root_category, product)
    [product.category].compact.presence || root_category.children
  end
end
