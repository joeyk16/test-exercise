class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :show, :update]
  before_action :correct_user_edit, only: [:edit, :update, :destroy]
  before_action :logged_in_user, only: [:new, :edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    @categories = Category.preload(:sizes).order(:name)
    @product.product_images.build
​
    @categories.each do |category|
      category.sizes.each do |size|
        @product.product_sizes.build(size_id: size.id, quantity: 0)
      end
    end
  end

  def home
    @products = Product.paginate(page: params[:page])
  end
​
  def edit
    @categories = Category.preload(:sizes)
​
    @categories.each do |category|
      category.sizes.each do |size|
        @product.product_sizes.detect do |ps|
          ps.size_id == size.id
        end || @product.product_sizes.build(size_id: size.id, quantity: 0)
      end
    end
  end
​
  def show
  end
​
  def update
    if @product.update(product_params)
       redirect_to @product
       flash[:success] = "Item was successfully updated."
    else
      render "edit"
    end
  end
​
  def create
    @product = Product.new product_params
    @product.user_id = current_user.id
    @categories = Category.preload(:sizes).order(:name)
​
    if @product.save
      redirect_to @product
      flash[:success] = "You have created a new product"
    else
      flash[:danger] = "Your product didn't save #{@product.errors.full_messages}"
      render "new"
    end
  end
​
  def destroy
    @product.destroy
    flash[:success] = "Product deleted"
    redirect_to user_products_path
  end
​
  def add_outfit_products
    @products = current_user.products
  end
​
  def add_outfit_similar_products
    @products = current_user.products
  end
​
  private

  def set_product
    @product = Product.find(params[:id])
  end
​
  def product_params
    params.require(:product).permit(
      :title,
      :price,
      :description,
      :tag_list,
      :category_id,
      :size_description,
      :shipping_description,
      product_images_attributes: [:product_image, :_destroy, :id],
      product_sizes_attributes: [:size_id, :quantity, :id]
    )
  end
​
  def correct_user_edit
    if @product = current_user.products.find_by(id: params[:id])
    else
      redirect_to root_url if @product.nil?
    end
  end
end
