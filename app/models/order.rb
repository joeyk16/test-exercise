class Order < ActiveRecord::Base
  belongs_to :product
  belongs_to :outfit
  belongs_to :size
  belongs_to :shipping_method
  belongs_to :user

  def total
    total = product.price_in_cents + shipping_method.price_in_cents
    total / 100.00
  end
end
