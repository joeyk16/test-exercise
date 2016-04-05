require 'paypal-sdk-adaptivepayments'
class PaypalAdaptivePayment
  def self.pay_all_orders(orders)
    @api = PayPal::SDK::AdaptivePayments::API.new
    receivers = {}
    orders.each do |order|
      receiver = {
        :receiver => [
          {
            :amount => order.product_price_in_cents + order.shipping_price_in_cents,
            :email => order.product.user.paypals.find_by(default: true).email
          }
        ]
      }
      receivers.merge!(receiver)
    end

    @pay = @api.build_pay(
      {
        :actionType => "PAY",
        :cancelUrl => "http://localhost:3000/samples/adaptive_payments/pay",
        :currencyCode => "USD",
        :feesPayer => "SENDER",
        :ipnNotificationUrl => "http://localhost:3000/samples/adaptive_payments/ipn_notify",
        :receiverList => receivers,
        :returnUrl => "http://localhost:3000/samples/adaptive_payments/pay"
      }
    )

    # Make API call & get response
    binding.pry
    @response = @api.pay(@pay)

    # Access response
    if @response.success? && @response.payment_exec_status != "ERROR"
      @response.payKey
      @api.payment_url(@response)  # Url to complete payment
    else
      @response.error[0].message
    end
  end
end
