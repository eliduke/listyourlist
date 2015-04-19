class ListsController < ApplicationController

  def index
    @lists = List.order(created_at: :desc)
  end

  def show
    @list = List.find(params[:id])
  end

end
