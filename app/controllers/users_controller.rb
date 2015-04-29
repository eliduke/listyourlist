class UsersController < ApplicationController

  def index
    @title = "All Users"
    @users = User.all.order(:login)
  end

  def show
    @user = User.find_by(login: params[:login])
    @title = @user.login
  end

  def seed
    @users    = User.unscoped.order(:id)
    @lists    = List.unscoped.order(:id)
    @items    = Item.unscoped.order(:id)
    @comments = Comment.unscoped.order(:id)
    @likes    = Like.unscoped.order(:id)

    render layout: false
  end

end
