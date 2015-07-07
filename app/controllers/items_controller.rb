class ItemsController < ApplicationController

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
    @item = Item.find(params[:id])
    @user = User.find(params[:id])
  end

  def show
    @item = Item.find(params[:id])
  end

  def update
    if @item.update(pin_params)
      redirect_to @item, notice: 'Item was successfully updated.'
    else
      render action: 'edit'
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
    redirect_to users_url
  end

  private

    def item_params
      params.require(:item).permit(:title, :price, :description, :image)
    end

end


