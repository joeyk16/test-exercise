class SizesController < ApplicationController
  before_action :admin_user, only: [:destroy, :index, :edit, :show]

	def new
		@size = Size.new
	end

  def create
    @size = Size.new(size_params)
    if @size.save
      redirect_to sizes_path
      flash[:success] = "You have created a new size"
    else
      render 'new'
    end
  end

  def index
  	@sizes = Size.all
  end

  def destroy
    Size.find(params[:id]).destroy
    flash[:sucess] = "Size deleted"
    redirect_to sizes_path
  end

  def edit
    @size = Size.find(params[:id])
  end

  def update
    @size = Size.find(params[:id])
    if @size.update_attributes(size_params)
      flash[:success] = "Size updated"
      redirect_to sizes_path
    else
      render 'edit'
    end
  end

private

  def size_params
    params.require(:size).permit(:title)
  end

  def admin_user
    redirect_to(root_url) unless current_user.try(:admin?)
  end

end 