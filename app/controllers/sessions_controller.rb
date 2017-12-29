class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      render :new, alert: "Your email and password were not correct."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "You are logged out."
  end
end
