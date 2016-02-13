class ShippingMethodsController < ApplicationController
  before_action :set_shipping_method,   only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  def new
    @shipping_method = ShippingMethod.new
  end

  def edit
  end

  def create
    @shipping_method = ShippingMethod.new(shipping_method_params)
    if @shipping_method.save
      redirect_to user_my_account_path
      flash[:success] = "Shipping Method Created"
    else
      flash[:danger] = "Shipping method didn't save"
      render "new"
    end
  end

  def update
    if @shipping_method.update_attributes(shipping_method_params)
       redirect_to user_my_account_path
       flash[:success] = 'Shipping method was successfully updated.'
    else
      render "edit"
    end
  end

  def destroy
    @shipping_method.destroy
    flash[:success] = "Shipping method deleted"
    redirect_to user_my_account_path(current_user)
  end

  private

  def set_shipping_method
    @shipping_method = ShippingMethod.find(params[:id])
  end

  def shipping_method_params
    params.require(:shipping_method).permit(
      :name,
      :user_id,
      :price_in_cents,
      :country
    )
  end
end
