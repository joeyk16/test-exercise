class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :edit]
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy, :index]

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def show
    @items = @user.items.paginate(page: params[:page])
  end

  def show_user_items
    @user = User.find(current_user)
    @items = @user.items.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :username,
      :email,
      :password,
      :password_confirmation,
      :avatar,
      :header_image,
      :description
    )
  end
end
