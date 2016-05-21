class PaypalNotification < ActiveRecord::Base
  belongs_to :order

  serialize :params
  after_create :update_order!

  private

  def update_order!
    orders = Order.where(tracking_code: self.tracking_code)
    orders.each { |order| order.paid! } if status == "Completed"
  end
end
