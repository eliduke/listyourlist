class AddDeletedToLists < ActiveRecord::Migration
  def change
    add_column :lists, :deleted, :boolean, null: false, default: false
  end
end
