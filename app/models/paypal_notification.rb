class PaypalNotification < ActiveRecord::Base
  belongs_to :order

  serialize :params
  after_create :update_order!

  private

  def update_order!
    if status == "Completed"
      orders = Order.where(paypal_pay_key: self.paypal_pay_key)
      orders.each do |order|
        order.paid
        order.save
      end
    end
  end
end
