class UsersController < ApplicationController

  def show
    @user = User.find_by(username: params[:username])
    @title = @user.username
  end

end
