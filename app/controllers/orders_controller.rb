class OrdersController < ApplicationController
  before_action :authenticate_user!
  # before_action :correct_user, only: [:edit, :update, :destroy]
  def index
    @orders = Order.where(user: current_user)
  end

  def edit
  end

  def create
    if create_orders
      PaypalAdaptivePayment.pay_all_orders(Order.where(user_id: current_user.id).payment)
      # redirect_to user_my_account_path
      # flash[:success] = "Order successfully was created"
    else
      flash[:danger] = "Order was not created"
    end
  end

  def update
    if @order.update(order_params)
       redirect_to user_my_account_path
       flash[:success] = 'Order was successfully updated'
    else
      render "edit"
    end
  end

  def destroy
    @order.destroy
    flash[:success] = "Order deleted"
    redirect_to user_my_account_path(current_user)
  end

  private

  def set_orders
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:user_id, :outfit_user_id, :product_id, :product_name,
      :product_price_in_cents, :size, :quantity, :shipping_price_in_cents,
      :shipping_method, :shipping_address
    )
  end

  def create_orders
    Cart.where(user: current_user).each do |item|
      Order.create(
        user_id: current_user.id,
        outfit_user_id: item.outfit.user.id,
        product_id: item.product_id,
        product_name: item.product.title,
        product_price_in_cents: item.product.price_in_cents,
        size: item.size.title,
        quantity: item.quantity,
        shipping_price_in_cents: item.shipping_method.price_in_cents,
        shipping_method: item.shipping_method.name,
        shipping_address: current_user.addresses.find_by(default_devlivery_address: true).address_to_s
      )
    end
  end

  # def correct_user
  #   redirect_to root_path unless current_user == @order.user
  # end
end
