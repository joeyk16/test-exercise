class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart_item, only: [:show, :destroy]
  before_action :redirect_unauthorized_user, only: [:show, :destroy]

  def index
    @cart_item = CartItem.where(user_id: current_user)
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    if @cart_item.save
      flash[:success] = "Product added to cart_item"
    else
      flash[:danger] = "#{@cart_item.errors.full_messages}"
    end
    redirect_to :back
  end

  def show
  end

  def destroy
    if @cart_item.delete
      redirect_to user_cart_items_path(current_user)
      flash[:success] = "CartItem has been deleted"
    else
      redirect_to user_cart_items_path(current_user)
      flash[:danger] =  "CartItem wasn't deleted"
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(
      :quantity,
      :product_id,
      :outfit_id,
      :size_id,
      :shipping_method_id,
      :user_id
    )
  end

  def set_cart_item
    @cart_item = CartItem.find_by(user_id: current_user)
  end

  def redirect_unauthorized_user
    redirect_to root_path unless current_user == @cart_item.user
  end
end
