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

ActiveRecord::Schema.define(version: 20160618131427) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accesses", force: :cascade do |t|
    t.integer  "claim_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "expiration"
  end

  create_table "administrators", force: :cascade do |t|
    t.string   "lastname"
    t.string   "login"
    t.string   "password_digest"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "personal_number"
    t.integer  "rank"
    t.boolean  "fired",           default: false
  end

  add_index "administrators", ["login"], name: "index_administrators_on_login", unique: true, using: :btree
  add_index "administrators", ["personal_number"], name: "index_administrators_on_personal_number", unique: true, using: :btree

  create_table "claims", force: :cascade do |t|
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "lastname"
    t.string   "phone"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "theme"
    t.text     "text"
    t.integer  "crew_id"
    t.integer  "administrator_id"
    t.boolean  "status",           default: false
  end

  create_table "claims_crews", id: false, force: :cascade do |t|
    t.integer "crew_id",  null: false
    t.integer "claim_id", null: false
  end

  create_table "crews", force: :cascade do |t|
    t.string   "car_number"
    t.string   "vin_number"
    t.boolean  "on_duty",      default: true
    t.boolean  "on_a_mission", default: false
    t.string   "latitude"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "longitude"
    t.string   "crew_name"
  end

  add_index "crews", ["car_number"], name: "index_crews_on_car_number", unique: true, using: :btree
  add_index "crews", ["vin_number"], name: "index_crews_on_vin_number", unique: true, using: :btree

end
