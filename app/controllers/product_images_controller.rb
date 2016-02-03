class ProductImagesController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @product_image = ProductImage.find(params[:id])
    if @product_image.destroy
      flash[:success] = "Image deleted"
    else
      flash[:danger] = "Image not deleted"
    end
    redirect_to :back
  end
end
