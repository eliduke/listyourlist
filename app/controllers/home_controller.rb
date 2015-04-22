class HomeController < ApplicationController

  def index
    @title = "Pointless List-Making at its Finest"
    @lists_new = List.order(created_at: :desc).limit(14)
    @lists_activity = List.where(id: Comment.order(created_at: :desc).limit(14).map(&:list_id).uniq)
    @lists_popular = List.order(hits: :desc).limit(14)
  end

  def about
    @title = "About"
  end
end
