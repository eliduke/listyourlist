class UsersController < ApplicationController

  def index
    @users = User.all.order(:login)
  end

  def show
    @user = User.find_by(login: params[:login])
  end

  def seed
    @users    = User.order(:id)
    @lists    = List.unscoped.order(:id)
    @items    = Item.unscoped.order(:id)
    @comments = Comment.order(:id)
    @likes    = Like.order(:id)

    render layout: false
  end

end
