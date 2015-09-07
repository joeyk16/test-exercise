class CategoriesController < ApplicationController
  before_action :set_category,   only: [:show]
  before_action :admin_user,     only: [:destroy, :index, :edit]

  def index
    @categories = Category.all
  end

  def show
    @tags = Item.where(category_id: @category.id).tag_counts_on(:tags)
    if params[:tag]
      @items = Item.tagged_with(params[:tag])
    else
      @items = Item.where(category_id: @category.id).order("created_at DESC")
    end
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category
      flash[:success] = "You have created a new category"
    else
      flash[:danger] = "Your category didn't save"
      render "new"
    end
  end

  def update
    @Cateogry = Category.find(params[:id])
    if @Cateogry.update(category_params)
       redirect_to @Cateogry
       flash[:success] = 'Category was successfully updated.'
    else
      render "edit"
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = "Category deleted"
    redirect_to categories_path
  end

  private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :parent_id)
    end
    
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.try(:admin?)
    end
    
end
