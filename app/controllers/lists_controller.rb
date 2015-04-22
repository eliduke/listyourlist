class ListsController < ApplicationController

  def index
    @title = "All Lists"
    @lists = List.order(created_at: :desc)
  end

  def show
    @list = List.find(params[:id])
    @title = "##{@list.id} - #{@list.title}"
  end

end
