class HomeController < ApplicationController
  before_action :authorize, only: [:dashboard, :seed]

  def index
    @title = "Pointless List-Making at its Finest"
    @lists_new = List.publik.order(created_at: :desc).limit(14)
    @lists_activity = List.publik.where(id: Comment.order(created_at: :desc).limit(14).map(&:list_id).uniq)
    @lists_popular = List.publik.order(hits: :desc).limit(14)
  end

  def about
    @title = "About"
  end

  def dashboard
    @title = "Dashboard / Admin"
    @publik_lists = current_user.lists.publik.order(created_at: :desc)
    @secret_lists = current_user.lists.secret.order(created_at: :desc)
    @priv8_lists = current_user.lists.priv8.order(created_at: :desc)
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
