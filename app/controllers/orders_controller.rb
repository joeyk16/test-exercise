class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :destroy]

  def index
    @order = Order.where(user_id: current_user)
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      flash[:success] = "Please Confirm your order"
    else
      flash[:danger] =  "Can't buy item"
    end
    redirect_to user_order_path(current_user, @order)
  end

  def show
  end

  def destroy
    if @order.delete
      redirect_to user_orders_path(current_user)
      flash[:success] = "Order has been deleted"
    else
      redirect_to user_orders_path(current_user)
      flash[:danger] =  "Order wasn't deleted"
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :quantity,
      :product_id,
      :outfit_id,
      :size_id,
      :shipping_method_id,
      :user_id
      )
  end

  def set_order
    @order = Order.find_by(user_id: current_user)
  end
end
