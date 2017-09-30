class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      set_last_login(user)
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in. Welcome back, #{user.first_name}!"
      redirect_to reservations_path
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

  private

  def set_last_login(user)
    user.last_login = Time.now
    user.save
  end
end
