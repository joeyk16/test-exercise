class Order < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :product

  has_many :paypal_notifications

  validates :user_id, :outfit_user_id, :product_id, :product_name, :product_price_in_cents,
            :size, :quantity, :shipping_price_in_cents, :shipping_method, :shipping_address,
            :aasm_state, presence: true

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

  def self.process_all_cart_items!(user)
    return false unless enough_quantity?(user)
    create_orders!(user)
    # user.carts.destroy_all
  end

  def self.enough_quantity?(user)
    Cart.where(user: user).each do |cart_item|
      product_size = ProductSize.find_by(product_id: cart_item.product_id, size_id: cart_item.size_id)
      if product_size.quantity > cart_item.quantity
        true
      else
        errors.add(:base, "#{product.title} doesn't have enough quantity")
        false
      end
    end
  end

  def self.create_orders!(user)
    Cart.where(user: user).each do |cart_item|
      Order.create(
        user_id: user.id,
        outfit_user_id: cart_item.outfit.user.id,
        product_id: cart_item.product_id,
        product_name: cart_item.product.title,
        product_price_in_cents: cart_item.product.price_in_cents,
        size: cart_item.size.title,
        size_id: cart_item.size_id,
        quantity: cart_item.quantity,
        shipping_price_in_cents: cart_item.shipping_method.price_in_cents,
        shipping_method: cart_item.shipping_method.name,
        shipping_address: user.addresses.find_by(default_devlivery_address: true).address_to_s
      )
    end
    add_tracking_id_to_orders(user)
  end

  def self.add_tracking_id_to_orders(user)
    orders = Order.where(user_id: user.id).payment
    tracking_id = create_tracking_id(orders)
    orders.each { |order| order.update_attributes(tracking_id: tracking_id) }
  end

  def self.create_tracking_id(orders)
    tracking_id = 0
    orders.each { |order| tracking_id += order.id }
    tracking_id
  end

  def total_price
    total = 0
    total += (product_price_in_cents + shipping_price_in_cents)
    total / 100.00
  end

  def drop_quantity!
    product_size = product.product_sizes.find_by(size_id: size_id)
    product_size.quantity -= quantity
  end
end
