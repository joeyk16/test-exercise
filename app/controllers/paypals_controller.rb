class PaypalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_paypals,   only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :user_has_one_default_paypal_account, only:[:create, :update]

  def new
    @paypal = Paypal.new
  end

  def edit
  end

  def create
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
       redirect_to user_my_account_path
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

  def user_has_one_default_paypal_account
    paypal = Paypal.find_by(user_id: current_user, default: true)
    if (params[:paypal][:default] == "1") && paypal
      paypal.update_attributes(default: false)
    end
  end

  def correct_user
    redirect_to root_path unless current_user == @paypal.user
  end
end
