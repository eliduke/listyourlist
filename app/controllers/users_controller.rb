class UsersController < ApplicationController

  def show
    @user = User.find_by(username: params[:login])
    @title = @user.username
  end

end
