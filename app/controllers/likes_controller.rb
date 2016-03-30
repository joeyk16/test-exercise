class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :one_like_per_outfit, only: [:create]

  def create
    @like = Like.new(likes_params)
    if @like.save
    else
      flash[:danger] = "Sorry there was an error"
    end
    redirect_to :back
  end

  def destroy
    if @like = Like.find_by(outfit: params[:id], user: current_user)
      @like.delete
    else
      flash[:danger] = "Sorry can't do that"
    end
    redirect_to :back
  end

  private

  def likes_params
    params.require(:likes).permit(
      :outfit_id,
      :user_id
    )
  end

  def one_like_per_outfit
    redirect_to :back if Like.find_by(likes_params)
  end
end