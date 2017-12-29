class HomeController < ApplicationController
  before_action :authorize, only: [:dashboard, :seed]

  def index
    @title = "Pointless List-Making at its Finest"
    @lists_new = List.publics.order(created_at: :desc).limit(14)
    @lists_activity = List.publics.where(id: Comment.order(created_at: :desc).limit(14).map(&:list_id).uniq)
    @lists_popular = List.publics.order(hits: :desc).limit(14)
  end

  def about
    @title = "About"
  end

  def dashboard
    @title = "Dashboard / Admin"
    @publics = current_user.lists.publics.order(created_at: :desc)
    @privates = current_user.lists.privates.order(created_at: :desc)
  end

  def seed
    if current_user.username == "eliduke"
      @users    = User.unscoped.order(:id)
      @lists    = List.unscoped.order(:id)
      @items    = Item.unscoped.order(:id)
      @comments = Comment.unscoped.order(:id)
      @likes    = Like.unscoped.order(:id)

      render layout: false
    else
      redirect_to dashboard_path
    end
  end
end
