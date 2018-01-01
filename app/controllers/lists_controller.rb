class ListsController < ApplicationController
  before_action :authorize, except: [:show]
  before_action :find_list, only: [:edit, :update, :destroy]

  def show
    @list = List.find_by(permalink: params[:id])

    @comment = Comment.new

    if @list.public? || current_user&.can_see(@list)
      @title = "#{@list.title} / #{@list.user.username}"
    else
      redirect_to root_path
    end
  end

  def new
    @title = "New List"
    @list = current_user.lists.new
    @list.items.build
  end

  def create
    @title = "New List"
    @list = current_user.lists.new(list_params)

    if @list.items.present? && @list.save
      redirect_to dashboard_path, notice: "Your list was created! 🎉"
    else
      @list.errors.add(:items, "A list must have at least one item") if @list.items.empty?
      @list.items.build
      render :new
    end
  end

  def edit
    @title = @list.title
  end

  def update
    if @list.update_attributes(list_params)
      redirect_to dashboard_path, notice: "Your list was updated. 🛠"
    else
      render :edit
    end
  end

  def destroy
    if @list.destroy
      return redirect_to dashboard_path, notice: "Your list was deleted. 😥"
    else
      render :edit
    end
  end

  private

  def find_list
    @list = List.find_by!(user: current_user, permalink: params[:id])
  end

  def list_params
    params.require(:list).permit(
      :user_id,
      :title,
      :description,
      :ordered,
      :commenting,
      :public,
      items_attributes: [:id, :body, :_destroy]
    )
  end
end
