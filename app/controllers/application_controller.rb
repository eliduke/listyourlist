class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    if user_id = session[:user_id]
      @current_user ||= User.find_by(id: user_id)
    elsif user_id = cookies.signed[:user_id]
      user = User.find_by(id: user_id)

      if user && user.authenticated?(cookies[:remember_token])
        helpers.login user
        @current_user ||= user
      # else
      #   helpers.logout
      #   redirect_to login_path, alert: "There was a problem logging you in. Please try again."
      end
    end
  end

  def authorize
    redirect_to login_path unless current_user
  end
end
