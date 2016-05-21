class CartItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :outfit
  belongs_to :size
  belongs_to :shipping_method
  belongs_to :user

  validates :product, :outfit, :size, :shipping_method, :user, :quantity, presence: true
  before_validation :error_if_user_owns_product, on: :create
  before_validation :error_if_not_enough_quantity, on: :create

  def total_price(quanity)
    ((product.price_in_cents * quanity) + shipping_method.price_in_cents) / 100.00
  end

  private

  def error_if_user_owns_product
    errors.add(:base, "Can't add own product to cart_item") if user == product.user
  end

  def error_if_not_enough_quantity
    if product.product_sizes.find_by(size_id: size_id).quantity <= quantity
      errors.add(:base, "Product doesn't have enough quantity")
    end
  end
end
