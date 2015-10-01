class ItemsController < ApplicationController
  before_action :correct_user_edit,   only: [:edit, :update, :destroy]

  def index
    @item = @user.items.paginate(page: params[:page])
  end

  def new
  	@item = Item.new
  end

  def home
    @item = Item.paginate(page: params[:page])
  end

  def edit
    @item = Item.find(params[:id])
    @user = User.find(params[:id])
  end

  def show
    @item = Item.find(params[:id])
    @user = @item.user
  end

  def update
    @item = Item.find(params[:id])
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

    def item_params
      params.require(:item).permit(:title, :category_id, :price, :description, :image, :tag_list)
    end

    #Check to see if user can edit item.
    def correct_user_edit
      if @item = current_user.items.find_by(id: params[:id])
      else
        flash[:danger] = "You can't edit that item"
        redirect_to root_url if @item.nil?
      end
    end

end


