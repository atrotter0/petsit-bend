class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password]) && user.activated?
      user.set_last_login
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in. Welcome back, #{user.first_name}!"
      redirect_to reservations_path
    elsif user && user.authenticate(params[:session][:password]) && !user.activated
      flash.now[:warning] = "Your account has not been activated. Please check your email for the account activation link."
      render 'new'
    else
      flash.now[:danger] = "Your email or password is incorrect."
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out."
    redirect_to root_path
  end
end
