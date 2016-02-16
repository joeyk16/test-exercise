class CartsController < ApplicationController
  before_action :authenticate_user!

  def create
    @cart = Cart.new(cart_params)
    if @cart.save
      flash[:success] = "Item added to cart"
    else
      flash[:danger] =  "Item didn't add to cart"
    end
    redirect_to :back
  end

  private

  def cart_params
    params.require(:cart).permit(
        :quantity,
        :product_id,
        :outfit_id,
        :size_id,
        :user_id
      )
  end
end
