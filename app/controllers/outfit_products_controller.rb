class OutfitProductsController < ApplicationController

  def create
    @outfit_product = OutfitProduct.new(outfit_product_params)
    if @outfit_product.save
      redirect_to user_outfit_path(id: @outfit_product.outfit_id, user_id: @outfit_product.product.user_id),
      notice: "Successfully Added Product"
    else
      render :new
    end
  end

  private

  def outfit_product_params
    params.permit(:outfit_id, :product_id)
  end
end