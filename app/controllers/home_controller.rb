class HomeController < ApplicationController

  def index
    @lists_new = List.order(created_at: :desc).limit(14)
    @lists_activity = List.where(id: Comment.order(created_at: :desc).limit(14).map(&:list_id).uniq)
    @lists_popular = List.order(hits: :desc).limit(14)
  end

  def about
  end
end
