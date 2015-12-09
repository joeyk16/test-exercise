class ProductForm
  # include SimpleFormObject
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_accessor :image, :title, :price, :description,
                :tag_list, :category_id, :size_id, :quantity

  def initialize(title = nil, price = nil, description = nil, tag_list = nil, category_id = nil, size = nil, quantity = nil)
    @title        = title
    @price        = price
    @description  = description
    @tag_list     = tag_list
    @category_id  = category_id
    @size         = size
    @quantity     = quantity
  end

  #Attributes for Product
  # attribute :image, :string
  # attribute :title, :string
  # attribute :price, :integer
  # attribute :description, :string
  # attribute :tag_list, :string
  #Atrributes for PorductSize
  # attribute :category_id, :string
  # attribute :size, :string
  # attribute :quantity, :string

  def persisted?
    false
  end

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
