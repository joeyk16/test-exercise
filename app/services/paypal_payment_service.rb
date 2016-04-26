class PaypalPaymentService
  attr_reader :user, :orders

  def initialize(user:, return_url:, orders:, notify_url:, tracking_id:)
    @user       = user
    @return_url = return_url
    @orders     = orders
    @notify_url = notify_url
    @tracking_id = tracking_id
  end

  def process!
    @response = paypal_api.pay(build_request)
    result = !!(@response.success? && @response.payment_exec_status != "ERROR")
    result
  end

  def build_request
    paypal_api.build_pay(
      actionType:         "PAY",
      cancelUrl:          "http://localhost:3000/samples/adaptive_payments/pay",
      currencyCode:       "USD",
      feesPayer:          "SENDER",
      ipnNotificationUrl: @notify_url,
      receiverList:       { receiver: receivers_list },
      reverseAllParallelPaymentsOnError: true,
      senderEmail:        @user.paypals.find_by(default: true).email,
      returnUrl:          @return_url,
      trackingId:         @tracking_id
    )
  end

  def payment_url
    paypal_api.payment_url(response)
  end

  private

  attr_reader :response

  def receivers_list
    @receivers = []
    @orders.each do |order|
      if current_user_owns_outfit?(order)
        one_payment(order)
      else
        split_payment(order)
      end
    end
    merge_payments_for_same_receiver(@receivers)
  end

  def current_user_owns_outfit?(order)
    order.user_id == order.outfit_user_id
  end

  def one_payment(order)
    receiver = {
      :amount => order.total_price.round(2),
      :email => order.product.user.paypals.find_by(default: true).email
    }
    @receivers << receiver
  end

  def split_payment(order)
    receiver_item = {
      :amount => ((order.total_price) * 0.9).round(2),
      :email => order.product.user.paypals.find_by(default: true).email
    }

    receiver_outfit_owner = {
      :amount => ((order.total_price) * 0.1).round(2),
      :email => User.find(order.outfit_user_id).paypals.find_by(default: true).email
    }
    @receivers << receiver_item
    @receivers << receiver_outfit_owner
  end

  def merge_payments_for_same_receiver(receivers)
    @receivers = receivers.group_by { |e| e[:email] }
      .map { |k, v| { amount: v.sum { |e| e[:amount] }, email: k } }
    @receivers.each { |email, amount| email[:amount] = email[:amount].round(2) }
  end

  def paypal_api
    @paypal_api ||= PayPal::SDK::AdaptivePayments::API.new
  end
end
