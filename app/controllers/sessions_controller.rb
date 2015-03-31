class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_path
    else
      flash[:danger] = "Incorrect email or password."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to sign_in_path
  end
end