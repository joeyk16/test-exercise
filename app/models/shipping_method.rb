class ShippingMethod < ActiveRecord::Base
  belongs_to :user
  has_many :cart_items

  validates :name, :user_id, :price_in_cents, :country, presence: true

  def price
    price_in_cents / 100.00
  end
end
