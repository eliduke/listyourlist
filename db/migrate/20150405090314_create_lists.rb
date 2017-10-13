class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.integer :user_id
      t.string :title
      t.boolean :ordered
      t.text :description
      t.boolean :published, null: false, default: :false
      t.integer :hits
      t.timestamps null: false
    end
  end
end
