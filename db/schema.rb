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

ActiveRecord::Schema.define(version: 20160420231354) do

  create_table "administrators", force: :cascade do |t|
    t.string   "lastname"
    t.string   "login"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "personal_number"
    t.integer  "rank"
  end

  add_index "administrators", ["login"], name: "index_administrators_on_login", unique: true
  add_index "administrators", ["personal_number"], name: "index_administrators_on_personal_number", unique: true

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

  create_table "crews", force: :cascade do |t|
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "car_number"
    t.integer  "vin_number"
    t.boolean  "underway",     default: true
    t.boolean  "on_a_mission", default: false
    t.string   "latitude"
    t.string   "longtitude"
  end

end
