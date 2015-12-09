class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :show, :update]
  before_action :correct_user_edit,   only: [:edit, :update, :destroy]
  before_action :logged_in_user, only: [:new, :edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def new
    @product_form = ProductForm.new
    @categories = Category.preload(:sizes).order(:name)
  end

  def home
    @products = Product.paginate(page: params[:page])
  end

  def edit
  end

  def show
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
    binding.pry
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product
      flash[:success] = "You have created a new product"
    else
      flash[:danger] = "Your product didn't save"
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
      :price,
      :description,
      :tag_list,
      :category_id,
      :size,
      :quantity
    )
  end

  def correct_user_edit
    if @product = current_user.products.find_by(id: params[:id])
    else
      redirect_to root_url if @product.nil?
    end
  end
end
