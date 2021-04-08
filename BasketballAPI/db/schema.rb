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

ActiveRecord::Schema.define(version: 2021_04_03_184155) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.string "firstName"
    t.string "lastName"
    t.string "phone"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "favoriter_id"
    t.bigint "favoritee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["favoritee_id"], name: "index_favorites_on_favoritee_id"
    t.index ["favoriter_id"], name: "index_favorites_on_favoriter_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.time "time"
    t.text "description"
    t.boolean "private"
    t.float "longitude"
    t.float "latitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "status"
    t.bigint "user_id"
    t.bigint "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_players_on_game_id"
    t.index ["user_id"], name: "index_players_on_user_id"
  end

  create_table "user_contacts", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "contact_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_user_contacts_on_contact_id"
    t.index ["user_id"], name: "index_user_contacts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.string "firstname"
    t.string "lastname"
    t.date "dob"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "api_key"
  end

  add_foreign_key "contacts", "users"
  add_foreign_key "favorites", "users", column: "favoritee_id"
  add_foreign_key "favorites", "users", column: "favoriter_id"
  add_foreign_key "players", "games"
  add_foreign_key "players", "users"
  add_foreign_key "user_contacts", "contacts"
  add_foreign_key "user_contacts", "users"
end
