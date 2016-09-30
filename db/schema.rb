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

ActiveRecord::Schema.define(version: 20160930221043) do

  create_table "apod_modules", force: :cascade do |t|
    t.string   "name"
    t.string   "base_query"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rover_modules", force: :cascade do |t|
    t.string   "name"
    t.string   "base_query"
    t.string   "full_query"
    t.string   "rover"
    t.string   "camera"
    t.string   "date"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "page_number"
    t.integer  "picture_count"
  end

  create_table "valid_rover_dates", force: :cascade do |t|
    t.string   "rover"
    t.string   "camera"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
