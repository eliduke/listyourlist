class ChangeListPublishedToPublic < ActiveRecord::Migration[5.1]
  def change
    rename_column :lists, :published, :public
    change_column_default :lists, :public, true
    change_column_null :lists, :public, false
  end
end
