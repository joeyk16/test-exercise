class CartItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :outfit
  belongs_to :size
  belongs_to :shipping_method
  belongs_to :user

  validates :product, :outfit, :size, :shipping_method, :user, :quantity, presence: true
  before_validation :user_cant_add_own_product
  before_validation :product_has_enough_quantity

  def item_price(quanity)
    total = (product.price_in_cents * quanity) + shipping_method.price_in_cents
    total / 100.00
  end

  def total_price(quanity)
    total = 0
    total += ((product.price_in_cents * quanity) + shipping_method.price_in_cents)
    total / 100.00
  end

  private

  def user_cant_add_own_product
    errors.add(:base, "Can't add own product to cart_item") if user == product.user
  end

  def product_has_enough_quantity
    if product.product_sizes.find_by(size_id: size_id).quantity <= quantity
      errors.add(:base, "Product doesn't have enough quantity")
    end
  end
end
