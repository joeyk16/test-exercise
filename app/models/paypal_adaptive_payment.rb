class PaypalAdaptivePay
  require 'paypal-sdk-rest'
  def self.pay_all_orders(orders)
    @api = PayPal::SDK::AdaptivePayments::API.new
  # Build request object
    @pay = @api.build_pay({
      binding.pry
      :actionType => "PAY",
      :cancelUrl => "http://localhost:3000/samples/adaptive_payments/pay",
      :currencyCode => "USD",
      :feesPayer => "SENDER",
      :ipnNotificationUrl => "http://localhost:3000/samples/adaptive_payments/ipn_notify",
      orders.each do |order|
        receiverList = {}
        receiverList << {
          :receiver => [
            {
              :amount => order.price_in_cents + order.shipping_price_in_cents,
              :email => order.user.paypals.find_by(default: true).email
            }
          ]
        }
      end
      receiverList,
      :returnUrl => "http://localhost:3000/samples/adaptive_payments/pay" })

    # Make API call & get response
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
