class StaticPagesController < ApplicationController

	def home
	end

  def index
    @items = Item.paginate(page: params[:page])
  end
	
end
