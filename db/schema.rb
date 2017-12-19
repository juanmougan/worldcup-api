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

ActiveRecord::Schema.define(version: 20171219024120) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "incidence_details", force: :cascade do |t|
    t.string "detail"
    t.integer "incidence"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "incidences", force: :cascade do |t|
    t.bigint "player_id"
    t.bigint "match_id"
    t.integer "incidence_type"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_incidences_on_match_id"
    t.index ["player_id"], name: "index_incidences_on_player_id"
  end

  create_table "matches", force: :cascade do |t|
    t.integer "home_goals"
    t.integer "away_goals"
    t.string "round"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "home_team_id"
    t.bigint "away_team_id"
    t.integer "order"
    t.index ["away_team_id"], name: "index_matches_on_away_team_id"
    t.index ["home_team_id"], name: "index_matches_on_home_team_id"
  end

  create_table "penalties", force: :cascade do |t|
    t.bigint "player_id"
    t.bigint "match_id"
    t.integer "length"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_penalties_on_match_id"
    t.index ["player_id"], name: "index_penalties_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "incidences", "matches"
  add_foreign_key "incidences", "players"
  add_foreign_key "matches", "teams", column: "away_team_id"
  add_foreign_key "matches", "teams", column: "home_team_id"
  add_foreign_key "penalties", "matches"
  add_foreign_key "penalties", "players"
  add_foreign_key "players", "teams"
  add_foreign_key "teams", "users"
end
