# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20130716220633) do

  create_table "rails_admin_histories", force: true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 5
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories"

  create_table "soms", force: true do |t|
    t.float    "mil_percent"
    t.float    "wage"
    t.float    "me"
    t.float    "ome"
    t.integer  "off"
    t.float    "dme"
    t.integer  "def"
    t.integer  "gens_home"
    t.integer  "soldiers_home"
    t.integer  "ospecs_home"
    t.integer  "dspecs_home"
    t.integer  "elites_home"
    t.integer  "horses_home"
    t.integer  "gens_1"
    t.integer  "gens_2"
    t.integer  "gens_3"
    t.integer  "gens_4"
    t.integer  "gens_5"
    t.integer  "soldiers_1"
    t.integer  "soldiers_2"
    t.integer  "soldiers_3"
    t.integer  "soldiers_4"
    t.integer  "soldiers_5"
    t.integer  "ospecs_1"
    t.integer  "ospecs_2"
    t.integer  "ospecs_3"
    t.integer  "ospecs_4"
    t.integer  "ospecs_5"
    t.integer  "dspecs_1"
    t.integer  "dspecs_2"
    t.integer  "dspecs_3"
    t.integer  "dspecs_4"
    t.integer  "dspecs_5"
    t.integer  "elites_1"
    t.integer  "elites_2"
    t.integer  "elites_3"
    t.integer  "elites_4"
    t.integer  "elites_5"
    t.integer  "horses_1"
    t.integer  "horses_2"
    t.integer  "horses_3"
    t.integer  "horses_4"
    t.integer  "horses_5"
    t.integer  "land_1"
    t.integer  "land_2"
    t.integer  "land_3"
    t.integer  "land_4"
    t.integer  "land_5"
    t.integer  "ospecs_training_1"
    t.integer  "ospecs_training_2"
    t.integer  "ospecs_training_3"
    t.integer  "ospecs_training_4"
    t.integer  "ospecs_training_5"
    t.integer  "ospecs_training_6"
    t.integer  "ospecs_training_7"
    t.integer  "ospecs_training_8"
    t.integer  "ospecs_training_9"
    t.integer  "ospecs_training_10"
    t.integer  "ospecs_training_11"
    t.integer  "ospecs_training_12"
    t.integer  "ospecs_training_13"
    t.integer  "ospecs_training_14"
    t.integer  "ospecs_training_15"
    t.integer  "ospecs_training_16"
    t.integer  "ospecs_training_17"
    t.integer  "ospecs_training_18"
    t.integer  "ospecs_training_19"
    t.integer  "ospecs_training_20"
    t.integer  "ospecs_training_21"
    t.integer  "ospecs_training_22"
    t.integer  "ospecs_training_23"
    t.integer  "ospecs_training_24"
    t.integer  "dspecs_training_1"
    t.integer  "dspecs_training_2"
    t.integer  "dspecs_training_3"
    t.integer  "dspecs_training_4"
    t.integer  "dspecs_training_5"
    t.integer  "dspecs_training_6"
    t.integer  "dspecs_training_7"
    t.integer  "dspecs_training_8"
    t.integer  "dspecs_training_9"
    t.integer  "dspecs_training_10"
    t.integer  "dspecs_training_11"
    t.integer  "dspecs_training_12"
    t.integer  "dspecs_training_13"
    t.integer  "dspecs_training_14"
    t.integer  "dspecs_training_15"
    t.integer  "dspecs_training_16"
    t.integer  "dspecs_training_17"
    t.integer  "dspecs_training_18"
    t.integer  "dspecs_training_19"
    t.integer  "dspecs_training_20"
    t.integer  "dspecs_training_21"
    t.integer  "dspecs_training_22"
    t.integer  "dspecs_training_23"
    t.integer  "dspecs_training_24"
    t.integer  "elites_training_1"
    t.integer  "elites_training_2"
    t.integer  "elites_training_3"
    t.integer  "elites_training_4"
    t.integer  "elites_training_5"
    t.integer  "elites_training_6"
    t.integer  "elites_training_7"
    t.integer  "elites_training_8"
    t.integer  "elites_training_9"
    t.integer  "elites_training_10"
    t.integer  "elites_training_11"
    t.integer  "elites_training_12"
    t.integer  "elites_training_13"
    t.integer  "elites_training_14"
    t.integer  "elites_training_15"
    t.integer  "elites_training_16"
    t.integer  "elites_training_17"
    t.integer  "elites_training_18"
    t.integer  "elites_training_19"
    t.integer  "elites_training_20"
    t.integer  "elites_training_21"
    t.integer  "elites_training_22"
    t.integer  "elites_training_23"
    t.integer  "elites_training_24"
    t.integer  "thieves_training_1"
    t.integer  "thieves_training_2"
    t.integer  "thieves_training_3"
    t.integer  "thieves_training_4"
    t.integer  "thieves_training_5"
    t.integer  "thieves_training_6"
    t.integer  "thieves_training_7"
    t.integer  "thieves_training_8"
    t.integer  "thieves_training_9"
    t.integer  "thieves_training_10"
    t.integer  "thieves_training_11"
    t.integer  "thieves_training_12"
    t.integer  "thieves_training_13"
    t.integer  "thieves_training_14"
    t.integer  "thieves_training_15"
    t.integer  "thieves_training_16"
    t.integer  "thieves_training_17"
    t.integer  "thieves_training_18"
    t.integer  "thieves_training_19"
    t.integer  "thieves_training_20"
    t.integer  "thieves_training_21"
    t.integer  "thieves_training_22"
    t.integer  "thieves_training_23"
    t.integer  "thieves_training_24"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sots", force: true do |t|
    t.string   "name"
    t.string   "loc"
    t.string   "utodate"
    t.string   "race"
    t.integer  "soldiers"
    t.string   "pers"
    t.integer  "ospecs"
    t.integer  "land"
    t.integer  "dspecs"
    t.integer  "peasants"
    t.integer  "elites"
    t.integer  "be"
    t.integer  "thieves"
    t.integer  "stealth"
    t.integer  "money"
    t.integer  "wizards"
    t.integer  "mana"
    t.integer  "food"
    t.integer  "horses"
    t.integer  "runes"
    t.integer  "prisoners"
    t.integer  "tb"
    t.integer  "off"
    t.integer  "def"
    t.boolean  "war"
    t.string   "dragon"
    t.boolean  "plague"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "nw"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
