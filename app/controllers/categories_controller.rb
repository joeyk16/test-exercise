class CategoriesController < ApplicationController
  before_action :set_category,   only: [:show, :edit, :update]
  before_action :logged_in_user, only: [:destroy, :index, :edit, :show, :new, :create, :update]
  before_action :admin_user,     only: [:destroy, :index, :edit, :show, :new, :create, :update]

  def index
    @categories = Category.all
  end

  def show
    @tags = Product.where(category_id: @category.id).tag_counts_on(:tags)
    if params[:tag]
      @products = Product.tagged_with(params[:tag])
    else
      @products = Product.where(category_id: @category.id).order("created_at DESC")
    end
  end

  def new
    @category = Category.new
    3.times do
      @category.sizes.build
    end
  end

  def edit
  end

  def create
    binding.pry
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
      flash[:success] = "You have created a new category"
    else
      flash[:danger] = "Your category didn't save"
      render "new"
    end
  end

  def update
    if @category.update(category_params)
       redirect_to categories_path
       flash[:success] = 'Category was successfully updated.'
    else
      render "edit"
    end
  end

  def destroy
    category = Category.find(params[:id])
    category.sizes.destroy_all
    category.destroy
    flash[:success] = "Category deleted"
    redirect_to categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :parent_id, size_ids: [], sizes_attributes: [:id, :title, :_destroy])
  end
end
