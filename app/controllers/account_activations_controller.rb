class AccountActivationsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:account_activations][:email].downcase)
    if @user && !@user.activated?
      @user.create_activation_reset_digest
      @user.send_account_activation
      flash[:warning] = "An email has been sent with an account activation link."
      redirect_to root_url
    elsif @user && @user.activated?
      flash.now[:danger] = "Invalid email address."
      render 'new'
    else
      flash.now[:danger] = "Invalid email address."
      render 'new'
    end
  end

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      user.set_last_login
      session[:user_id] = user.id
      flash[:success] = "Account successfully activated! Welcome to Petsit Bend, #{user.first_name}!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link."
      redirect_to root_url
    end
  end
end
