class AddSecretIdToLists < ActiveRecord::Migration[5.1]
  def change
    add_column :lists, :secret_id, :string
    add_index :lists, :secret_id, unique: true
  end
end
