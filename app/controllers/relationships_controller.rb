class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @relationships = current_user.relationships.all
  end

  def create
    @relationship = Relationship.new(relationship_params)
    if @relationship.save
      flash[:success] = "Relationship was successfully created."
    else
      flash[:damger] = "Relationship was not deleted"
    end
    redirect_to :back
  end

  def destroy
    @relationship = Relationship.find(params[:id])
    if @relationship.destroy
      flash[:success] = "Relationship was successfully deleted."
    else
      flash[:danger] = "Relationship was not deleted."
    end
    redirect_to :back
  end

  private

  def relationship_params
    params.require(:relationship).permit(:following_id, :user_id)
  end
end
