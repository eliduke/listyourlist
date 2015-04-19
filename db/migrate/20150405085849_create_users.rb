class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :email
      t.string :full_name
      t.string :display_name
      t.string :location
      t.string :url
      t.string :bio
    end
  end
end
