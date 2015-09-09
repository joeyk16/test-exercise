class SizesController < ApplicationController
  before_action :admin_user, only: [:destroy, :index, :edit, :show]

	def new
		@size = Size.new
	end

  def create
    @size = Size.new(size_params)
    if @size.save
      redirect_to sizes_path
    else
      render 'new'
    end
  end

  def index
  	@sizes = Size.all
  end

private

  def size_params
    params.require(:size).permit(:title)
  end

  def admin_user
    redirect_to(root_url) unless current_user.try(:admin?)
  end

end
