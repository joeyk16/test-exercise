class Order < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :product

  aasm do
    state :payment, :initial => true
    state :cancel
    state :processing
    state :shipped
    state :complete

    event :paid do
      transitions :from => :payment, :to => :processing
    end

    event :shipped do
      transitions :from => :processing, :to => :shipped
    end

    event :complete do
      transitions :from => :shipped, :to => :complete
    end

    event :cancel do
      transitions :from => :payment, :to => :cancel
    end
  end

  def total_price
    total = 0
    total += (product_price_in_cents + shipping_price_in_cents)
    total / 100.00
  end

  def self.create_orders!(user)
    Cart.where(user: user).each do |item|
      Order.create(
        user_id: user.id,
        outfit_user_id: item.outfit.user.id,
        product_id: item.product_id,
        product_name: item.product.title,
        product_price_in_cents: item.product.price_in_cents,
        size: item.size.title,
        quantity: item.quantity,
        shipping_price_in_cents: item.shipping_method.price_in_cents,
        shipping_method: item.shipping_method.name,
        shipping_address: user.addresses.find_by(default_devlivery_address: true).address_to_s
      )
    end
  end
end
