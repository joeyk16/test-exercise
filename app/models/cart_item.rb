class CartItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :outfit
  belongs_to :size
  belongs_to :shipping_method
  belongs_to :user
end
