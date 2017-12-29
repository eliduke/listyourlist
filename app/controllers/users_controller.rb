class UsersController < ApplicationController
  before_action :authorize, :find_user,
    only: [:edit, :update, :change_password, :update_password]

  def show
    @user = User.find_by(username: params[:username])

    if @user
      @title = @user.username
    else
      redirect_to root_path
    end
  end

  def new
    redirect_to dashboard_path if current_user

    @title = "Sign Up"
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      @title = "Sign Up"
      render :new, alert: "Your account was not created. See below for details."
    end
  end

  def edit
    @title = "Edit your account"
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to dashboard_path, notice: "Your account info was updated. 👍🏼"
    else
      @title = "Edit your account"
      render :edit, alert: "Your account info did not save. See below for details."
    end
  end

  def change_password
  end

  def update_password
    if @user.authenticate(user_params[:current_password])
      @user.password = user_params[:password]
      @user.password_confirmation = user_params[:password_confirmation]

      if @user.save
        redirect_to settings_path, notice: "Your password was changed. 👍🏼"
      else
        render :change_password, alert: "Something's not right here... 🤔"
      end
    else
      @user.errors.add(:current_password, "was not correct")
      render :change_password, alert: "Something's not right here... 🤔"
    end
  end

  private

  def find_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(
      :username,
      :email,
      :full_name,
      :location,
      :url,
      :bio,
      :password,
      :password_confirmation,
      :current_password
    )
  end
end
