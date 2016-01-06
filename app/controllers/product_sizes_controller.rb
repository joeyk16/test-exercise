class ProductSizesController < ApplicationController
  before_action :logged_in_user, only: [:destroy, :index, :edit, :show, :new, :create, :update]
  before_action :admin_user,     only: [:destroy, :index, :edit, :show, :new, :create, :update]

  def new
    @product_size = ProductSize.new
  end

  def create
    product_size = ProductSize.new(product_size_params)
    product_size.save
  end

  private

  def product_size_params
    params.require(:product_size).permit(:product_id, :size_id, :quantity )
  end
end
