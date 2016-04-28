class PaypalNotificationsController < ApplicationController
  protect_from_forgery except: :create

  def create
    PaypalNotification.create(
      notification: params,
      tracking_code: params[:txn_id],
      status: params[:payment_status],
    )
    render :nothing => true
  end
end
