class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Account successfully created! Welcome to the Petsit Bend, #{@user.first_name}!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Your account was successfully updated!"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @user.destroy
    flash[:danger] = "User was successfully deleted!"
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :first_name, :last_name, :phone, :address)
  end

  def set_user
    @user = User.find(params[:id])
  end
end