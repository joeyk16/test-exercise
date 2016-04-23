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
    add_invoice_id_to_orders(user)
  end

  def self.add_invoice_id_to_orders(user)
    orders = Order.where(user_id: user.id).payment
    invoice_id = self.create_invoice_id(orders)
    orders.each { |order| order.update_attributes(invoice_id: invoice_id) }
  end

  def self.create_invoice_id(orders)
    invoice_id = 0
    orders.each { |order| invoice_id += order.id }
    invoice_id
  end

  def total_price
    total = 0
    total += (product_price_in_cents + shipping_price_in_cents)
    total / 100.00
  end
end
