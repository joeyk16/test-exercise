class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_orders, only: [:edit, :destroy]
  before_action :unauthorized_user, only: [:destroy]

  def index
    @orders = Order.where(user: current_user)
  end

  def edit
  end

  def create
    if Order.process_all_cart_items!(current_user)
      make_paypal_payment!
    else
      flash[:danger] = paypal_payment.errors
      redirect_to user_carts_path(current_user)
    end
  end

  def destroy
    @order.destroy
    flash[:success] = "Order deleted"
    redirect_to user_my_account_path(current_user)
  end

  private

  def make_paypal_payment!
    paypal_payment = PaypalPaymentService.new(paypal_params)
    if paypal_payment.process!
      redirect_to paypal_payment.payment_url
    else
      flash[:danger] = paypal_payment.errors
      redirect_to user_carts_path(current_user)
    end
  end

  def paypal_params
    {
      user: current_user,
      return_url: root_url,
      orders: current_user_orders_awaiting_payment,
      notify_url: paypal_notifications_url,
      tracking_code: current_user_orders_awaiting_payment[0].tracking_code
    }
  end

  def current_user_orders_awaiting_payment
    Order.where(user_id: current_user.id).payment
  end

  def set_orders
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:user_id, :outfit_user_id, :product_id, :product_name,
      :product_price_in_cents, :size, :quantity, :shipping_price_in_cents,
      :shipping_method, :shipping_address
    )
  end

  def unauthorized_user
    redirect_to root_path unless current_user == @order.user
  end
end
