# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171229185212) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "list_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "deleted"
  end

  create_table "items", id: :serial, force: :cascade do |t|
    t.integer "list_id"
    t.string "body"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", id: :serial, force: :cascade do |t|
    t.integer "list_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lists", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.boolean "ordered"
    t.text "description"
    t.boolean "public", default: true, null: false
    t.integer "hits"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "permalink"
    t.boolean "commenting", default: true, null: false
    t.boolean "deleted"
    t.index ["permalink"], name: "index_lists_on_permalink"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "full_name"
    t.string "location"
    t.string "url"
    t.string "bio"
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "deleted"
  end

end
