class PaypalAdaptivePaymentService
  attr_reader :user, :return_url, :orders

  def initialize(params)
    @user = params[:user]
    @return_url = params[:return_url]
    @orders = params[:orders]
    @notify_url = params[:notify_url]
    @invoice_id = params[:invoice_id]
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
        :invoice => @invoice_id,
        :returnUrl => @return_url
      }
    )
    binding.pry
  end

  private

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
  end
end
