class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :update, :edit]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:create, :new, :destroy, :index]

  def index
    @users = User.all
  end

  def new
  	@user = User.new
  end

  def show
    @products = @user.products.paginate(page: params[:page])
  end

  def show_user_products
    @user = User.find(current_user)
    @products = @user.products.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User Created"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to :back
    else
      render 'edit'
      flash[:danger] = "Profile updated"
    end
  end

  def destroy
    @user =  User.find(params[:id])
    if @user.destroy
      flash[:success] = "User deleted"
    else
      flash[:danger] = "User did not delete"
    end
    redirect_to users_path
  end

  def destroy_avatar
    if current_user.avatar?
      current_user.avatar.destroy
      current_user.save
      flash[:success] = "Image deleted"
    else
      flash[:danger] = "Image did not delete"
    end
    redirect_to :back
  end

  def destroy_header_image
    if current_user.header_image?
      current_user.header_image = nil
      current_user.save
      flash[:success] = "Image deleted"
    else
      flash[:danger] = "Image did not delete"
    end
    redirect_to :back
  end

  def my_account
    @user = current_user
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
      :date_of_birth,
      :first_name,
      :last_name,
      :avatar,
      :header_image,
      :description
    )
  end

  def correct_user
    redirect_to root_path unless current_user == @user
  end
end
