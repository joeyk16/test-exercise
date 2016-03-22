class OutfitProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_outfit, only: [:destroy, :approve, :decline]
  before_action :outfit_product_exists, only: [:create]
  before_action :outfit_products_limit, only: [:create]

  def create
    @outfit_product = OutfitProduct.new(outfit_product_params)
    case user_owns_outfit
    when true
      outfit_saved_instantly_approved
    when false
      outfit_saved_waiting_approval
    else
      redirect_to outfit_path
      flash[:danger] = "Sorry you can't add your product"
    end
  end

  def users_outfit_products
    @outfit_products = current_user.outfit_products
  end

  def outfit_products
    #add layer for security here.
    @outfit_products = Outfit.find(params[:outfit_id]).outfit_products
  end

  def destroy
    @outfit_product.destroy
    redirect_to :back
    flash[:success] = "Successfully destroyed product for outfit"
  end

  def approve
    @outfit_product.update_attributes(approved: true)
    redirect_to :back
    flash[:success] = "Successfully approved product for outfit"
  end

  def decline
    @outfit_product.update_attributes(approved: false)
    redirect_to :back
    flash[:success] = "Successfully declined product for outfit"
  end

  def add_outfit_products
    @products = current_user.products
  end

  private

  def set_outfit
    @outfit_product = OutfitProduct.find(params[:id])
  end

  def outfit_product_exists
    outfit_product = OutfitProduct.find_by(outfit_id: params[:outfit_id], product_id: params[:product_id])
    if outfit_product == nil
    else
      redirect_to user_outfit_path(id: params[:outfit_id], user_id: params[:user_id])
      flash[:info] = "Product already associated with this outfit"
    end
  end

  def outfit_products_limit
    outfit_product = OutfitProduct.where(outfit_id: params[:outfit_id])
    if (outfit_product == nil) || (outfit_product.count < 6)
    else
      redirect_to user_outfit_path(id: params[:outfit_id], user_id: params[:user_id])
      flash[:danger] = "Outfit has too many products. Limit is 6 per outfit"
    end
  end

  def outfit_product_params
    params.permit(:outfit_id, :product_id, :user_id)
  end

  def user_owns_outfit
    Outfit.find(params[:outfit_id]).user_id == current_user.id
  end

  def outfit_saved_instantly_approved
    @outfit_product.save
    @outfit_product.update_attributes(approved: true)
    redirect_to outfit_path
    flash[:success] = "Successfully Added Product"
  end

  def outfit_saved_waiting_approval
    @outfit_product.save
    redirect_to outfit_path
    flash[:info] = "Please wait for outfit owner to approve your product"
  end

  def outfit_path
    user_outfit_path(id: @outfit_product.outfit_id, user_id: @outfit_product.product.user_id)
  end
end
