class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :list_id
      t.string :body
      t.integer :position

      t.timestamps null: false
    end
  end
end
