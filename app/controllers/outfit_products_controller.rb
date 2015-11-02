class OutfitProductsController < ApplicationController
  # before_action :correct_user, only: [:create, :destroy]
  # before_action :logged_in_user, only: [:create, :destroy]

  def create
    @outfit_product = OutfitProduct.new(outfit_product_params)
    if user_owns_outfit
      @outfit_product.save
      @outfit_product.update_attributes(approved: true)
      redirect_to user_outfit_path(id: @outfit_product.outfit_id, user_id: @outfit_product.product.user_id)
      flash[:success] = "Successfully Added Product"
    elsif @outfit_product.save
      redirect_to user_outfit_path(id: @outfit_product.outfit_id, user_id: @outfit_product.product.user_id)
      flash[:info] = "Please wait for outfit owner to approve your product"
    else
      redirect_to user_outfit_path(id: @outfit_product.outfit_id, user_id: @outfit_product.product.user_id)
      flash[:danger] = "Sorry you can't add your product"
    end
  end

  private

  def outfit_product_params
    params.permit(:outfit_id, :product_id)
  end

  def user_owns_outfit
    Outfit.find(params[:outfit_id]).user_id == current_user.id
  end
end
