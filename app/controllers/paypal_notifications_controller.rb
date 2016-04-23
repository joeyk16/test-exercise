class PaypalNotificationsController < ApplicationController
  protect_from_forgery except: :create

  def create
    binding.pry
    PaypalNotification.create(
      notification: params,
      paypal_pay_key: params[:pay_key],
      status: params[:payment_status],
    )
    render :nothing => true
  end
end
