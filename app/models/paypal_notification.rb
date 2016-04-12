class PaypalNotification < ActiveRecord::Base
  belongs_to :order

  serialize :params
  after_create :mark_cart_as_purchased

  private

  def mark_cart_as_purchased
    if status == "Completed"
      order.paid
    end
  end
end
