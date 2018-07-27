class RemoveSoftDeleteColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :deleted, :boolean
    remove_column :lists, :deleted, :boolean
    remove_column :comments, :deleted, :boolean
  end
end
