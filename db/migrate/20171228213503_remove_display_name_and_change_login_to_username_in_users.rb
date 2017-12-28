class RemoveDisplayNameAndChangeLoginToUsernameInUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :display_name, :string
    rename_column :users, :login, :username
  end
end
