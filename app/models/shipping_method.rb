class ShippingMethod < ActiveRecord::Base
  belongs_to :user
  has_many :cart_items
end
