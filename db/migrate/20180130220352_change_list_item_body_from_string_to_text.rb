class ChangeListItemBodyFromStringToText < ActiveRecord::Migration[5.1]
  def up
    change_column :items, :body, :text
  end

  def down
    change_column :items, :body, :string
  end
end
