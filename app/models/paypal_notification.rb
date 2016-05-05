class PaypalNotification < ActiveRecord::Base
  belongs_to :order

  serialize :params
  after_create :update_order!

  private

  def update_order!
    orders = Order.where(tracking_code: self.tracking_code)
    if status == "Completed"
      orders.each do |order|
        order.paid!
      end
    end
  end
end
