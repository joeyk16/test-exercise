class PaypalGateway
  def initialize(user:, orders:, return_url:, notify_url:)
    @user          = user
    @orders        = orders
    @return_url    = return_url
    @notify_url    = notify_url
    @tracking_code = orders.first.tracking_code
  end

  def process!
    @response = paypal_api.pay(build_request)
    !!(@response.success? && @response.payment_exec_status != "ERROR")
  end

  def build_request
    paypal_api.build_pay(
      actionType:         "PAY",
      cancelUrl:          return_url,
      currencyCode:       "USD",
      feesPayer:          "SENDER",
      senderEmail:        user.paypal_email,
      returnUrl:          return_url,
      ipnNotificationUrl: notify_url,
      trackingId:         tracking_code,
      receiverList:       { receiver: receivers },
      reverseAllParallelPaymentsOnError: true
    )
  end

  def payment_url
    paypal_api.payment_url(response)
  end

  private

  attr_reader :response, :user, :orders, :return_url, :notify_url, :tracking_code

  def paypal_api
    @paypal_api ||= PayPal::SDK::AdaptivePayments::API.new
  end

  def receivers
    @receivers = []
    orders.each do |order|
      product_email = order.product.user.paypal_email
      outfit_email  = order.outfit_user.paypal_email
      if order.user_owns_outfit?
        receiver = { email: product_email, amount: amount(order.total_price) }
      else
        receiver = { email: product_email, amount: amount(order.total_price, 0.9) }
        outfit_receiver = { email: outfit_email,  amount: amount(order.total_price, 0.1) }
        @receivers << outfit_receiver
      end
      @receivers << receiver
    end
    merge_same_receivers(@receivers)
  end

  def merge_same_receivers(receivers)
    receivers.group_by { |receiver| receiver[:email] }.map do |email, amount|
      { email: email, amount: amount.inject(0) { |start_ammount,receiver| start_ammount + receiver[:amount] } }
    end
  end

  def amount(price, factor = 1.0)
    (price * factor).round(2)
  end
end
