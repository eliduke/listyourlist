class CommentsController < ApplicationController
  before_action :authorize
  before_action :find_list, only: [:create, :edit, :update, :destroy]
  before_action :find_comment, only: [:edit, :update, :destroy]

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.list = @list

    if @comment.save
      redirect_to list_path(@list) + "#comment_#{@comment.id}", notice: "Your comment was created! 🎉"
    end
  end

  def edit
  end

  def update
    if @comment.update_attributes(comment_params)
      redirect_to list_path(@comment.list), notice: "Your comment was updated. 🛠"
    else
      render :edit
    end
  end

  def destroy
    if @comment.destroy
      redirect_to list_path(@comment.list), notice: "Your comment was deleted. 😥"
    end
  end

  private

  def find_list
    @list = List.find_by!(permalink: params[:list_id])
  end

  def find_comment
    @comment = Comment.find_by!(id: params[:id])
  end

  def comment_params
    params.require(:comment).permit(
      :user_id,
      :list_id,
      :body
    )
  end
end
