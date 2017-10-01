class UsersController < ApplicationController
  include PaginateHelper
  include PetHelper
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_user, only: [:index, :edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:index, :edit, :update, :show, :destroy]
  before_action :require_admin, only: [:destroy]

  def index
    @users = User.all.order("last_login DESC").paginate(paginate_settings(20))
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.last_login = Time.now
    if @user.save
      session[:user_id] = @user.id
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
    params.require(:user).permit(:username, :password, :email, :first_name, :last_name, :phone, :address)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:danger] = "You can only edit your own account."
      redirect_to root_path
    end
  end

  def require_admin
    if logged_in? and !current_user.admin?
      flash[:danger] = "Only admin users can perform that action."
      redirect_to root_path
    end
  end
end
