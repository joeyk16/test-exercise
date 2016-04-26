class PaypalNotification < ActiveRecord::Base
  belongs_to :order

  serialize :params
  after_create :update_order!

  private

  def update_order!
    orders = Order.where(tracking_id: self.tracking_id)
    if status == "Completed"
      orders.each do |order|
        order.paid
        order.drop_quantity!
        order.save
      end
    end
  end
end
