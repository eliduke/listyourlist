module Admin
  class AdminController < ApplicationController
    before_action :authorize

    def dashboard
      @title = "Dashboard / Admin"
      @publics = current_user.lists.publics.order(created_at: :desc)
      @privates = current_user.lists.privates.order(created_at: :desc)
    end

    def seed
      if current_user.login == "eliduke"
        @users    = User.unscoped.order(:id)
        @lists    = List.unscoped.order(:id)
        @items    = Item.unscoped.order(:id)
        @comments = Comment.unscoped.order(:id)
        @likes    = Like.unscoped.order(:id)

        render layout: false
      else
        redirect_to admin_dashboard_path
      end
    end
  end
end
