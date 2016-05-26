class PaypalAdaptivePaymentService
  attr_reader :user, :return_url, :orders

  def initialize(params)
    @user = params[:user]
    @return_url = params[:return_url]
    @orders = params[:orders]
    @notify_url = params[:notify_url]
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
        :receiverList => {
          :receiver => receivers_list
        },
        :reverseAllParallelPaymentsOnError => true,
        :senderEmail => @user.paypals.find_by(default: true).email,
        :notify_url => @notify_url,
        :returnUrl => @return_url
      }
    )
  end

  private

  def receivers_list
    receivers = []
    @orders.each do |order|
      receiver_item = {
        :amount => ((order.total_price) * 0.9).round(2),
        :email => order.product.user.paypals.find_by(default: true).email
      }

      receiver_outfit_owner = {
        :amount => ((order.total_price) * 0.1).round(2),
        :email => User.find(order.outfit_user_id).paypals.find_by(default: true).email
      }
      receivers << receiver_item
      receivers << receiver_outfit_owner
    end
    receivers
  end
end
