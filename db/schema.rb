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

ActiveRecord::Schema.define(version: 20160822134326) do

  create_table "attachment_files", force: :cascade do |t|
    t.integer  "access_level"
    t.string   "file_type"
    t.string   "file_name"
    t.string   "file_url"
    t.integer  "profile_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string   "text"
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "access_level"
    t.string   "text"
    t.integer  "profile_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "login"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "tokens", force: :cascade do |t|
    t.integer  "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_infos", force: :cascade do |t|
    t.string   "key"
    t.string   "value"
    t.integer  "access_level"
    t.integer  "profile_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
