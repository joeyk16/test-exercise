class Cart < ActiveRecord::Base
  belongs_to :product
  belongs_to :outfit
  belongs_to :size
  belongs_to :shipping_method
  belongs_to :user

  validates :product, :outfit, :size, :shipping_method, :user, :quantity, presence: true
  before_validation :user_cant_add_own_product

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
    errors.add(:base, "Can't add own product to cart") if user == product.user
  end
end
