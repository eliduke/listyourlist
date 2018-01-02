class AddSecureIdToLists < ActiveRecord::Migration[5.1]
  def change
    add_column :lists, :secure_id, :string
    add_index :lists, :secure_id, unique: true
  end
end
