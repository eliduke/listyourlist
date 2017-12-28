module Admin
  class ListsController < Admin::AdminController
    before_action :find_list, only: [:edit, :update, :destroy]

    def new
      @title = "New List"
      @list = current_user.lists.new
      @list.items.build
    end

    def create
      @list = current_user.lists.new(list_params)

      if @list.items.present? && @list.save
        redirect_to admin_dashboard_path
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
        redirect_to admin_dashboard_path
      else
        render :edit
      end
    end

    def destroy
      if @list.destroy
        return redirect_to admin_dashboard_path
      else
        render :edit
      end
    end

    private

    def find_list
      @list = List.unscoped.find_by!(user: current_user, permalink: params[:id])
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
end
