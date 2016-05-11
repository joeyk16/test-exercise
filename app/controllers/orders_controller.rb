class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_orders, only: [:edit, :destroy, :update, :add_shipping_code,
                                    :ship!, :cancel!, :show, :complete!]
  before_action :redirect_unauthorized_user, only: [:destroy]

  def index
    @orders = Order.where(user: current_user)
  end

  def show
  end

  def edit
  end

  def update
    if @order.update(order_params)
      redirect_to user_orders_path(current_user)
      flash[:success] = "Order was successfully updated"
    else
      render "edit"
      flash[:danger] = "Order didn't update"
    end
  end

  def create
    if Order.process_all_cart_items!(current_user)
      make_paypal_payment!
    else
      flash[:danger] = paypal_payment.errors
      redirect_to user_cart_items_path(current_user)
    end
  end

  def destroy
    @order.destroy
    flash[:success] = "Order deleted"
    redirect_to user_my_account_path(current_user)
  end

  def add_shipping_code
    if @order.update(order_params)
      flash[:success] = "Shipping code added"
    else
      flash[:danger] = "Couldn't add shipping code"
    end
    redirect_to :back
  end

  def ship!
    if @order.shipped!
      flash[:success] = "Status changed to shipped"
    else
      flash[:danger] = "Couldn't change status"
    end
    redirect_to :back
  end

  def cancel!
    if @order.cancel!
      flash[:success] = "Order canceled"
    else
      flash[:danger] = "Couldn't change status"
    end
    redirect_to :back
  end

  def complete!
    if @order.complete!
      flash[:success] = "Order completed"
    else
      flash[:danger] = "Couldn't change status"
    end
    redirect_to :back
  end

  private

  def make_paypal_payment!
    paypal_payment = PaypalGateway.new(paypal_params)
    if paypal_payment.process!
      redirect_to paypal_payment.payment_url
    else
      flash[:danger] = "Your order did not process"
      redirect_to user_cart_items_path(current_user)
    end
  end

  def paypal_params
    {
      user: current_user,
      return_url: root_url,
      orders: orders_awaiting_payment,
      notify_url: paypal_notifications_url,
      tracking_code: orders_awaiting_payment[0].tracking_code
    }
  end

  def orders_awaiting_payment
    Order.where(user_id: current_user.id).payment
  end

  def set_orders
    @order = Order.find(params[:id] || params[:format])
  end

  def order_params
    params.require(:order).permit(:user_id, :outfit_user_id, :product_id, :product_name,
      :product_price_in_cents, :size, :quantity, :shipping_price_in_cents,
      :shipping_method, :shipping_address, :shipping_code
    )
  end

  def redirect_unauthorized_user
    redirect_to root_path unless current_user == @order.user
  end
end
