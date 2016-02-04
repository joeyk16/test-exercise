class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :update, :edit]
  before_action :correct_user, only: [:edit, :update]
  before_action :current_user, only: [:my_account, :user_details_form]
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
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user =  User.find(params[:id])
    if @user.destroy
      redirect_to users_path
      flash[:success] = "User deleted"
    else
      redirect_to users_path
      flash[:danger] = "User did not delete"
    end
  end

  def my_account
  end

  def user_details_form
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

  def correct_user
    redirect_to root_path unless current_user == @user
  end

  def current_user
    @user = current_user
  end
end
