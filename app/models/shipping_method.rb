class ShippingMethod < ActiveRecord::Base
  belongs_to :user

  validates :name, :user_id, :price_in_cents, :country, presence: true
end
