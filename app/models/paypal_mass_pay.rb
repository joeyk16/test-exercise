require 'paypal-sdk-rest'
class PaypalMassPay
  @api = PayPal::SDK::AdaptivePayments::API.new

  # Build request object
  @pay = @api.build_pay({
    :actionType => "PAY",
    :cancelUrl => "https://paypal-sdk-samples.herokuapp.com/adaptive_payments/pay",
    :currencyCode => "AUS",
    :feesPayer => "SENDER",
    :ipnNotificationUrl => "https://paypal-sdk-samples.herokuapp.com/adaptive_payments/ipn_notify",
    :receiverList => {
      :receiver => [
        {
          :amount => 1.0,
          :email => "platfo_1255612361_per@gmail.com"
        }
      ]
    },
    :returnUrl => "https://paypal-sdk-samples.herokuapp.com/adaptive_payments/pay",
    :sender => {
      :email => "james@gmail.com",
      :useCredentials => false } })

  # Make API call & get response
  @pay_response = @api.pay(@pay)

  # Access Response
  if @pay_response.success?
    @pay_response.payKey
    @pay_response.paymentExecStatus
    @pay_response.payErrorList
    @pay_response.paymentInfoList
    @pay_response.sender
    @pay_response.defaultFundingPlan
    @pay_response.warningDataList
  else
    @pay_response.error
  end
end
