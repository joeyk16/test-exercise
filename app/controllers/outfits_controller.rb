class OutfitsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :outfits]
  before_action :set_outfit, only: [:show, :edit, :update, :destroy]
  before_action :user_has_paypal_account?, except: [:show, :index, :outfits]
  before_action :correct_user?, only: [:edit, :update, :destroy]

  def index
    @outfits = current_user.outfits.all
  end

  def outfits
    if params[:tag]
      @tag = params[:tag]
      @outfits = Outfit.tagged_with(params[:tag])
    else
      @outfits = Outfit.all
    end
  end

  def show
  end

  def new
    @outfit = Outfit.new
  end

  def edit
  end

  def create
    @outfit = Outfit.new(outfit_params)
    @outfit.update_attributes(user: current_user)
    if @outfit.save
      redirect_to user_outfit_path(@outfit, user_id: current_user), notice: 'Outfit was successfully created.'
    else
      render :new
    end
  end

  def update
    if @outfit.update(outfit_params)
      redirect_to user_outfit_path(@outfit, user_id: current_user), notice: 'Outfit was successfully updated.'else
      render :edit
    end
  end

  def destroy
    @outfit.destroy
    redirect_to user_outfits_path(current_user), notice: 'Outfit was successfully destroyed.'
  end

  private
    def set_outfit
      @outfit = Outfit.find(params[:id])
    end

    def outfit_params
      params.require(:outfit).permit(:caption, :outfit_image, :user_id, :tag_list)
    end

  def correct_user?
    redirect_to root_path unless @outfit.user == current_user
  end
end
