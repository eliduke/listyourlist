class ListsController < ApplicationController

  def index
    @title = "All Lists"
    @lists = List.order(created_at: :desc)
  end

  def show
    @list = List.find_by(permalink: params[:id])

    if @list.public? || current_user&.can_see(@list)
      @title = "#{@list.title} / #{@list.user.login}"
    else
      redirect_to root_path
    end
  end

end
