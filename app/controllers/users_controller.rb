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
      flash[:success] = "Welcome to the Alpha Blog, #{@user.username}!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit
  end

  def show
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:username, :email)
  end

  def set_user
    @user = User.find(params[:id])
  end
end