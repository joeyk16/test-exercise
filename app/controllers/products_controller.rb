class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :show, :update]
  before_action :correct_user_edit,   only: [:edit, :update, :destroy]
  before_action :logged_in_user, only: [:new, :edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
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
    @form = ProductForm.new(title: product_params[:title],
      price: product_params[:price],
      description: product_params[:description],
      tag_list: product_params[:tag_list],
      category_id: product_params[:category_id],
      sizes_by_id: product_params[:sizes_by_id],
      user: current_user)

    if @form.save
      redirect_to @form.product
      flash[:success] = "You have created a new product"
    else
      flash[:danger] = "Your product didn't save"
      new
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
      ).merge(sizes_by_id: params[:product_form][:sizes_by_id]) # TODO
  end

  def correct_user_edit
    if @product = current_user.products.find_by(id: params[:id])
    else
      redirect_to root_url if @product.nil?
    end
  end
end
