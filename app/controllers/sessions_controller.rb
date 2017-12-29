class SessionsController < ApplicationController
  def new
    redirect_to dashboard_path if current_user
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      helpers.login(user)

      if params[:remember_me] == "1"
        helpers.remember(user)
      else
        helpers.forget(user)
      end

      redirect_to dashboard_path
    else
      render :new, alert: "Your email and password were not correct. 🤔"
    end
  end

  def destroy
    helpers.logout
    redirect_to login_path, notice: "You are totally logged out. 🤙🏼"
  end
end
