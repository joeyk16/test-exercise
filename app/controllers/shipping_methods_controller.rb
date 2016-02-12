class ShippingMethodsController < ApplicationController
  before_action :set_shiping_method,   only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  def new
    @shiping_method = ShippingMethod.new
  end

  def edit
  end

  def create
    @shiping_method = ShippingMethod.new(shiping_method_params)
    @shiping_method.user = current_user
    if @shiping_method.save
      redirect_to user_my_account_path
      flash[:success] = "Shipping Method Created"
    else
      flash[:danger] = "Shiping method didn't save"
      render "new"
    end
  end

  def update
    if @shiping_method.update(shiping_method_params)
       redirect_to user_my_account_path
       flash[:success] = 'Shipping method was successfully updated.'
    else
      render "edit"
    end
  end

  def destroy
    @shiping_method.destroy
    flash[:success] = "Shipping method deleted"
    redirect_to user_my_account_path(current_user)
  end

  private

  def set_shiping_method
    @shiping_method = ShippingMethod.find(params[:id])
  end

  def shiping_method_params
    params.require(:shiping_method).permit(
    :name,
    :user_id,
    :price,
    :country
    )
  end
end
