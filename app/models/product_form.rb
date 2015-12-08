class ProductForm
  include SimpleFormObject


  #Attributes for Product
  # attribute :image, :string
  attribute :title, :string
  attribute :price, :integer
  attribute :description, :string
  attribute :tag_list, :string
  #Atrributes for PorductSize
  attribute :category_id, :string
  attribute :size, :string
  attribute :quantity, :string

#   def persisted?
#     false
#   end

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
