class Order < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :product

  has_many :paypal_notifications

  validates :user_id, :outfit_user_id, :product_id, :product_name, :product_price_in_cents,
            :size, :quantity, :shipping_price_in_cents, :shipping_method, :shipping_address,
            :aasm_state, presence: true

  aasm do
    state :pending_payment, :initial => true
    state :cancel
    state :processing
    state :shipped
    state :complete

    event :paid do
      transitions :from => :pending_payment, :to => :processing
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

  def self.process!(user)
    create_user_orders!(user)
    bad_name_2(user)
    user.cart_items.destroy_all end

  def self.create_user_orders!(user)
    CartItem.where(user: user).each do |item|
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

  def self.bad_name_2(user)
    orders = Order.where(user_id: user.id).pending_payment
    tracking_code = self.create_tracking_code(orders)
    orders.each { |order| order.update_attributes(tracking_code: tracking_code) }
  end

  def self.create_tracking_code(orders)
    tracking_code = 0
    orders.each { |order| tracking_code += order.id }
    tracking_code
  end

  def total_price
    total = 0
    total += (product_price_in_cents + shipping_price_in_cents)
    total / 100.00
  end
end
