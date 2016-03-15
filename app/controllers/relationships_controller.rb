class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def following
    @relationships = Relationship.where(user_id: params[:user_id])
  end

  def followers
    @relationships = Relationship.where(following_id: params[:user_id])
  end

  def create
    @relationship = Relationship.new(relationship_params)
    if @relationship.unique && @relationship.save
      flash[:success] = "Relationship was successfully created."
    else
      flash[:damger] = "Relationship was not created."
    end
    redirect_to :back
  end

  def destroy
    @relationship = Relationship.find(params[:id])
    if user_owns_relationship && @relationship.destroy
      flash[:success] = "Relationship was successfully deleted."
    else
      flash[:danger] = "Relationship was not deleted."
    end
    redirect_to :back
  end

  private

  def user_owns_relationship
    @relationship.user == current_user
  end

  def relationship_params
    params.require(:relationship).permit(:following_id, :user_id)
  end
end
