class ProductForm
  include Virtus.model

  # extend ActiveModel::Naming
  # include ActiveModel::Conversion
  # include ActiveModel::Validations

  attribute :title, String
  attribute :price, Integer
  attribute :description, String
  attribute :tag_list, String

  attribute :category_id, String
  attribute :size, String
  attribute :quantity, String

  # validates :email, presence: true
  # … more validations …

  # Forms are never themselves persisted
  def persisted?
    false
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

private

  def persist!
    @product = Product.create!(name: company_name)
    @product_size = ProductSize.create!(name: name, email: email)
  end
end