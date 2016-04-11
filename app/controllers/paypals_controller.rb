class PaypalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_paypals,   only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @paypal = Paypal.new
  end

  def edit
  end

  def create
    binding.pry
    @paypal = Paypal.new(paypal_params)
    if @paypal.save
      redirect_to user_my_account_path
      flash[:success] = "Paypal email was created"
    else
      flash[:danger] = "Your paypal account didn't save"
      render "new"
    end
  end

  def update
    if @paypal.update(paypal_params)
       redirect_to :back
       flash[:success] = 'Paypal was successfully updated'
    else
      render "edit"
    end
  end

  def destroy
    @paypal.destroy
    flash[:success] = "Paypal deleted"
    redirect_to user_my_account_path(current_user)
  end

  def payment_details
    @payment_details = api.build_payment_details(params[:PaymentDetailsRequest] || default_api_value)
    @payment_details_response = api.payment_details(@payment_details) if request.post?
  end

  private

  def set_paypals
    @paypal = Paypal.find(params[:id])
  end

  def paypal_params
    params.require(:paypal).permit(
      :email,
      :user_id,
      :default
    )
  end

  def correct_user
    redirect_to root_path unless current_user == @paypal.user
  end
end
