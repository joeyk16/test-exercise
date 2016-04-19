require 'paypal-sdk-adaptivepayments'
class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_orders, only: [:edit, :destroy]
  before_action :correct_user, only: [:destroy]

  def index
    @orders = Order.where(user: current_user)
  end

  def edit
  end

  def create
    adjust_product_quantity
    Order.process!(current_user)
    paypal_request
    if @response.success? && @response.payment_exec_status != "ERROR"
      @response.payKey
      redirect_to @paypal_api.payment_url(@response)
    else
      redirect_to user_carts_path(current_user)
      flash[:danger] = "#{@response.error[0].message}"
    end
  end

  def adjust_product_quantity
    current_user.carts.each do |cart|
      if Product.enough_quantity?(cart)
        Product.adjust_quantity!(cart)
      else
        redirect_to :back
        flash[:danger] = "Product #{cart.product.title} doesn't have enough quantity"
      end
    end
  end

  def destroy
    @order.destroy
    flash[:success] = "Order deleted"
    redirect_to user_my_account_path(current_user)
  end

  private

  def paypal_request
    @paypal_api = PayPal::SDK::AdaptivePayments::API.new
    @response = @paypal_api.pay(
      PaypalAdaptivePaymentService.new(paypal_params).build_paypal_api_request
    )
  end

  def paypal_params
    {
      user: current_user,
      return_url: root_url,
      orders: current_user_orders_awaiting_payment,
      notify_url: paypal_notifications_url,
      invoice_id: current_user_orders_awaiting_payment[0].invoice_id
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

  def correct_user
    redirect_to root_path unless current_user == @order.user
  end
end
