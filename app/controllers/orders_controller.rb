class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_orders, except: [:index, :create]
  before_action :redirect_unauthorized_user, except: [:index, :create]

  def index
    @orders = Order.where(user: current_user).order('created_at DESC')
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
    if Order.process_cart_items!(current_user)
      make_paypal_payment!
    else
      flash[:danger] = paypal_payment.errors
      redirect_to user_cart_items_path(current_user)
    end
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
    if @order.may_shipped?
      @order.shipped!
      flash[:success] = "Status changed to shipped"
    else
      flash[:danger] = "Can't ship order while #{@order.aasm_state}"
    end
    redirect_to :back
  end

  def cancel!
    if @order.may_cancel?
      @order.cancel!
      flash[:success] = "Order canceled"
    else
      flash[:danger] = "Can't cancel order while #{@order.aasm_state}"
    end
    redirect_to :back
  end

  def complete!
    if @order.may_complete?
      @order.complete!
      flash[:success] = "Order completed"
    else
      flash[:danger] = "Can't complete order while #{@order.aasm_state}"
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
      orders: orders_pending_payment,
      notify_url: paypal_notifications_url
    }
  end

  def orders_pending_payment
    Order.where(user: current_user).pending_payment
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
    redirect_to root_path unless (current_user == @order.user) || (current_user.id == @order.product_user_id)
  end
end
