# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_08_13_025323) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "decks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_decks_on_user_id"
  end

  create_table "decks_piece_cards", id: false, force: :cascade do |t|
    t.bigint "deck_id"
    t.bigint "piece_card_id"
    t.index ["deck_id"], name: "index_decks_piece_cards_on_deck_id"
    t.index ["piece_card_id"], name: "index_decks_piece_cards_on_piece_card_id"
  end

  create_table "games", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "guest_id", null: false
    t.integer "host_id", null: false
    t.jsonb "squares"
    t.datetime "updated_at", null: false
  end

  create_table "piece_cards", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "guest_symbol", null: false
    t.string "host_symbol", null: false
    t.integer "level"
    t.string "name"
    t.jsonb "rules", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pieces", force: :cascade do |t|
    t.integer "piece_card_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.integer "level", default: 0, null: false
    t.string "motto"
    t.string "name", null: false
    t.string "password_digest", null: false
    t.string "role", default: "User", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "decks", "users"
end
