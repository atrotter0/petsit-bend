class PasswordResetsController < ApplicationController
  before_action :get_user,         only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:warning] = "Email sent with password reset instructions!"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found."
      render 'new'
    end
  end

  def edit
    redirect_to root_url unless @user || @user.reset_sent_at.nil?
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "can't be blank")
      render 'edit'
    elsif @user.update_attributes(user_params)
      session[:user_id] = @user.id
      flash[:success] = "Password has been reset."
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "Password reset has expired."
      redirect_to new_password_reset_url
    end
  end
end
