class ItemsController < ApplicationController

  def index
    @items = Item.paginate(page: params[:page])
  end

  def new
  	@item = Item.new
  end

  def edit
  end

  def show
    @item = Item.find(params[:id])
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

  private

    def item_params
      params.require(:item).permit(:title, :price, :description, :image)
    end

end


