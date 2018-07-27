class ListsController < ApplicationController
  before_action :authorize, except: [:show]
  before_action :find_list, only: [:edit, :update, :destroy]

  def show
    secret_list = List.find_by(secret_id: params[:id])

    if secret_list
      @list = secret_list
      @title = "#{@list.title} / #{@list.user.username}"
      @comment = Comment.new
    else
      @list = List.find_by(permalink: params[:id])
      @comment = Comment.new

      if @list&.publik? || current_user.owns?(@list)
        @title = "#{@list.title} / #{@list.user.username}"
      else
        redirect_to root_path
      end
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
    before = @list.status
    after = list_params[:status]

    if @list.update_attributes(list_params)
      process_secret_id(before, after)
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

  def process_secret_id(before, after)
    if before != "secret" && after == "secret"
      @list.regenerate_secret_id
    end

    if before == "secret" && after != "secret"
      @list.update_attribute(:secret_id, nil)
    end
  end

  def list_params
    params.require(:list).permit(
      :user_id,
      :title,
      :description,
      :ordered,
      :commenting,
      :status,
      items_attributes: [:id, :body, :position, :_destroy]
    )
  end
end
