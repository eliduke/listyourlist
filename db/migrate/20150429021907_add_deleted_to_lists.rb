class AddDeletedToLists < ActiveRecord::Migration
  def change
    add_column :lists, :deleted, :boolean
  end
end
