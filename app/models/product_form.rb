class ProductForm
  attr_reader :quantity_by_size_id, :product

  def initialize(image:, title:, price:, description:, tag_list:, category_id:, sizes_by_id:, user:)
    @quantity_by_size_id = sizes_by_id # TODO
    @product = Product.new(image: image,title: title, price: price, description: description,
      tag_list: tag_list, category_id: category_id, user: user)
    build_product_sizes
  end

  def save
    product.save
  end

  private

  def build_product_sizes
    quantity_by_size_id.map do |size_id, quantity|
      if quantity.to_i.nonzero?
        product.product_sizes.build(product: product, size_id: size_id, quantity: quantity)
      end
    end
  end

  # def product_size_attributes
  #   @product_size_attributes ||= Category.all.each do |category|
  #     ProductSize.build(product: super, size: )
  #   end
  # end


                # <% category.sizes.each do |size| %>
                #   <%= f.simple_fields_for 'product_size_attributes', do |psf| %>
                #     <%= psf.hidden_field :size_id, value: size.id %>
                #     <%= psf.input :quantity, label: size.title %>
                #   <% end %>
                # <% end %>

  # def to_partial_path
  #   super
  # end
  # include SimpleFormObject
  # include ActiveModel::Validations
  # include ActiveModel::Conversion

  # attr_accessor :image, :title, :price, :description,
  #               :tag_list, :category_id, :size_id, :quantity

  # def persisted?
  #   false
  # end

#   def save
#     if valid?
#       persist!
#       true
#     else
#       false
#     end
#   end

# private

#   def persist!
#     @product = Product.create!(name: company_name)
#     @product_size = ProductSize.create!(name: name, email: email)
#   end
end
