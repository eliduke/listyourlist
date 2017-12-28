module Admin
  class UsersController < Admin::AdminController
    skip_before_action :authorize, only: [:new, :create]

    def new
      redirect_to admin_dashboard_path if current_user
      @title = "Sign Up"
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to admin_dashboard_url, notice: 'Thank you for signing up!'
      else
        render :new
      end
    end

    private

    def user_params
      params.require(:user).permit(
        :username,
        :email,
        :full_name,
        :location,
        :url,
        :bio,
        :deleted,
        :password,
        :password_confirmation
      )
    end
  end
end
