class AddCommentingBooleanToLists < ActiveRecord::Migration[5.1]
  def change
    add_column :lists, :commenting, :boolean, default: true, null: false
  end
end
