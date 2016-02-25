class Cart < ActiveRecord::Base
  belongs_to :product
  belongs_to :outfit
  belongs_to :size
  belongs_to :shipping_method
  belongs_to :user

  validates :product, :outfit, :size, :shipping_method, :user, presence: true

  def total(quanity)
    total = (product.price_in_cents * quanity) + shipping_method.price_in_cents
    total / 100.00
  end
end
