class UsersController < ApplicationController

  def show
    @user = User.find_by(login: params[:login])
    @title = @user.login
  end

end
