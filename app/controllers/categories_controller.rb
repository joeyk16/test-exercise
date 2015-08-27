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
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
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
