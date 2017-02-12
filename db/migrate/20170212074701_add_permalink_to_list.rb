class AddPermalinkToList < ActiveRecord::Migration
  def self.up
    add_column :lists, :permalink, :string
    add_index :lists, :permalink
  end
  def self.down
    remove_column :lists, :permalink
  end
end