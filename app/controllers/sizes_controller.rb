class SizesController < ApplicationController
  before_action :authenticate_user!
  before_action :logged_in_user
  before_action :admin_user

  def show
    @size = Size.find(params[:id])
  end

  def create
    @size = Size.new(size_params)
    if @size.save
      flash[:success] = "Size was successfully created"
      redirect_to sizes_path
    else
      flash[:danger] = "Size wasn't created"
      render :new
    end
  end

  def new
    @size = Size.new
  end

  def index
  	@sizes = Size.all
  end

  def edit
    @size = Size.find(params[:id])
  end

  def destroy
    Size.find(params[:id]).destroy
    redirect_to sizes_path
    flash[:success] = "Size was successfully deleted"
  end

  def update
    size = Size.find(params[:id])
    if size.update_attributes(size_params)
      redirect_to sizes_path
      flash[:success] = "Size was successfully updated"
    else
      redirect :back
      flash[:danger] = "Size didn't update"
    end
  end

  private

  def size_params
    params.require(:size).permit(:title, :category_id)
  end
end
