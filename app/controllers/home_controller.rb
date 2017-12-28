class HomeController < ApplicationController

  def index
    @title = "Pointless List-Making at its Finest"
    @lists_new = List.publics.order(created_at: :desc).limit(14)
    @lists_activity = List.publics.where(id: Comment.order(created_at: :desc).limit(14).map(&:list_id).uniq)
    @lists_popular = List.publics.order(hits: :desc).limit(14)
  end

  def about
    @title = "About"
  end
end
