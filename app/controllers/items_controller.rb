class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :show, :update]
  before_action :correct_user_edit,   only: [:edit, :update, :destroy]

  def index
    @item = @user.items.paginate(page: params[:page])
  end

  def new
  	@item = Item.new
  end

  def home
    @items = Item.paginate(page: params[:page])
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    if @item.update(item_params)
       redirect_to @item
       flash[:success] = 'Item was successfully updated.'
    else
      render "edit"
    end
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to @item
      flash[:success] = "You have created a new item"
    else
      flash[:danger] = "Your item didn't save"
      render "new"
    end
  end

  def destroy
    Item.find(params[:id]).destroy
    flash[:success] = "Item deleted"
    redirect_to user_items_path
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:title, :category_id, :price, :description, :image, :tag_list)
  end

  def correct_user_edit
    if @item = current_user.items.find_by(id: params[:id])
    else
      flash[:danger] = "You can't edit that item"
      redirect_to root_url if @item.nil?
    end
  end
end