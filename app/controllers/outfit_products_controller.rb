class OutfitProductsController < ApplicationController
  # before_action :correct_user, only: [:create, :destroy]
  # before_action :logged_in_user, only: [:create, :destroy]

  def create
    #create outfit_product with user_id == params["outfit_user_id"]
    #then user will only see the outfit_products that belong to them on edit page.
    binding.pry
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

  def edit
    @outfit_products = current_user.outfit_products
  end

  def destroy
    @outfit_product = OutfitProduct.find(params[:id])
    @outfit_product.destroy
    redirect_to user_outfit_products_path(params[:user_id])
    flash[:success] = "Successfully destroyed product for outfit"
  end

  def approve
    @outfit_product = OutfitProduct.find(params[:id])
    @outfit_product.update_attributes(approved: true)
    redirect_to user_outfit_products_path(params[:user_id])
    flash[:success] = "Successfully approved product for outfit"
  end

  def decline
    @outfit_product = OutfitProduct.find(params[:id])
    @outfit_product.update_attributes(approved: false)
    redirect_to user_outfit_products_path(params[:user_id])
    flash[:success] = "Successfully declined product for outfit"
  end

  private

  def outfit_product_params
    params.permit(:outfit_id, :product_id, :user_id)
  end

  def user_owns_outfit
    Outfit.find(params[:outfit_id]).user_id == current_user.id
  end
end
