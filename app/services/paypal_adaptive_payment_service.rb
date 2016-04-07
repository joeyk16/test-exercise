class PaypalAdaptivePaymentService
    attr_reader :user, :return_url, :orders

    def initialize(params)
      @user = params[:user]
      @return_url = params[:return_url]
      @orders = params[:orders]
    end

  def build_paypal_api_request
    paypal_api = PayPal::SDK::AdaptivePayments::API.new
    paypal_api.build_pay(
      {
        :actionType => "PAY",
        :cancelUrl => "http://localhost:3000/samples/adaptive_payments/pay",
        :currencyCode => "USD",
        :feesPayer => "SENDER",
        :ipnNotificationUrl => "http://localhost:3000/samples/adaptive_payments/ipn_notify",
        :receiverList => receivers_list,
        :reverseAllParallelPaymentsOnError => true,
        :senderEmail => @user.paypals.find_by(default: true).email,
        :returnUrl => @return_url
      }
    )
  end

  private

  def receivers_list
    receivers = {}
    @orders.each do |order|
      receiver = {
        :receiver => [
          {
            :amount => order.total_price,
            :email => order.product.user.paypals.find_by(default: true).email
          }
        ]
      }
      receivers.merge!(receiver)
    end
    receivers
  end
end
