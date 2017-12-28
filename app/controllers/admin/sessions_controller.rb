module Admin
  class SessionsController < Admin::AdminController
    skip_before_action :authorize

    def new
    end

    def create
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to admin_dashboard_path
      else
        redirect_to login_path
      end
    end

    def destroy
      session[:user_id] = nil
      redirect_to login_path
    end
  end
end
