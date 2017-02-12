class ListsController < ApplicationController

  def index
    @title = "All Lists"
    @lists = List.order(created_at: :desc)
  end

  def show
    @list = List.find_by(permalink: params[:id])
    @title = "#{@list.title} / #{@list.user.login}"
  end

  def new
    @title = "New List"
    @list = List.new
    @list.items.build
  end

end
