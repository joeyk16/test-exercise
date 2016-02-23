class PaypalsController < ApplicationController
  before_action :set_paypals,   only: [:edit, :update, :destroy]
  before_action :authenticate_user!

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
      :user_id
    )
  end
end
