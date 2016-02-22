class AddressesController < ApplicationController
  before_action :set_address,   only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @addresses = Address.where(user: current_user)
  end

  def new
    @address = Address.new
  end

  def edit
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to user_my_account_path
      flash[:success] = "Address Created"
    else
      flash[:danger] = "Your address didn't save"
      render "new"
    end
  end

  def update
    if @address.update(address_params)
       redirect_to user_my_account_path
       flash[:success] = 'Address was successfully updated.'
    else
      render "edit"
    end
  end

  def destroy
    @address.destroy
    flash[:success] = "Address deleted"
    redirect_to user_my_account_path(current_user)
  end

  private

  def set_address
    @address = Address.find(params[:id])
  end

  def address_params
    params.require(:address).permit(
      :default_devlivery_address,
      :default_billing_address,
      :address_line_1,
      :address_line_2,
      :suburb,
      :state,
      :postcode,
      :country,
      :user_id
    )
  end
end
