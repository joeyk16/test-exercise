class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index, :home]
  before_action :set_product, only: [:edit, :show, :update, :destroy]
  before_action :redirect_user_with_no_paypal_account, except: [:show, :index, :home]
  before_action :redirect_unauthorized_user, only: [:edit, :update, :destroy]

  def index
    if params[:tag]
      @tag = params[:tag]
      @products = Product.tagged_with(params[:tag])
    else
      @products = Product.all
    end
  end

  def new
    @product = Product.new
    @root_categories = Category.where(ancestry: nil).preload(:sizes).order(:name)
    @product.product_images.build

    @root_categories.each do |root_category|
      root_category.children.each do |category|
        category.sizes.each do |size|
          @product.product_sizes.build(size_id: size.id, quantity: 0)
        end
      end
    end
  end

  def home
    @products = Product.paginate(page: params[:page])
  end

  def edit
    category = @product.category         # T-Shirt
    @root_categories = [category.parent] # Men

    category.sizes.each do |size|
      @product.product_sizes.detect do |ps|
        ps.size_id == size.id
      end || @product.product_sizes.build(size_id: size.id, quantity: 0)
    end

    @product.product_images.build unless @product.product_images.any?
  end

  def show
    @cart_item = CartItem.new
    @sizes = @product.sizes
    @shipping = @product.product_shipping_methods
  end

  def update
    if @product.update(product_params)
       redirect_to @product
       flash[:success] = 'Item was successfully updated.'
    else
      render "edit"
    end
  end

  def create
    @product = Product.new product_params
    @product.user = current_user
    @root_categories = Category.preload(:sizes).order(:name)

    if @product.save
      redirect_to @product
      flash[:success] = "You have created a new product"
    else
      flash[:danger] = "Your product didn't save #{@product.errors.full_messages}"
      render "new"
    end
  end

  def destroy
    @product.destroy
    flash[:success] = "Product deleted"
    redirect_to user_products_path
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
     params.require(:product).permit(
      :title,
      :price_in_cents,
      :description,
      :tag_list,
      :category_id,
      :size_description,
      :shipping_description,
      product_images_attributes: [:product_image, :_destroy, :id],
      product_sizes_attributes: [:size_id, :quantity, :id]
    )
  end

  def redirect_unauthorized_user
    redirect_to root_path unless @product.user == current_user
  end
end
