class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: [:show, :destroy]

  def index
    @cart = Cart.where(user_id: current_user)
  end

  def create
    @cart = Cart.new(cart_params)
    if @cart.save
      flash[:success] = "Product added to cart"
    else
      flash[:danger] =  "Can't buy product"
    end
    redirect_to user_cart_path(current_user, @cart)
  end

  def show
  end

  def destroy
    if @cart.delete
      redirect_to user_carts_path(current_user)
      flash[:success] = "Cart has been deleted"
    else
      redirect_to user_carts_path(current_user)
      flash[:danger] =  "Cart wasn't deleted"
    end
  end

  private

  def cart_params
    params.require(:cart).permit(
      :quantity,
      :product_id,
      :outfit_id,
      :size_id,
      :shipping_method_id,
      :user_id
      )
  end

  def set_cart
    @cart = Cart.find_by(user_id: current_user)
  end
end
