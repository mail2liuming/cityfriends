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

ActiveRecord::Schema.define(version: 20160814234226) do

  create_table "calendars", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "feed_id"
    t.integer  "calendar_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.datetime "exact_time"
  end

  add_index "calendars", ["feed_id"], name: "index_calendars_on_feed_id"
  add_index "calendars", ["user_id"], name: "index_calendars_on_user_id"

  create_table "feeds", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "feed_type"
    t.string   "feed_content"
    t.string   "start_place"
    t.datetime "start_time"
    t.string   "end_place"
    t.datetime "end_time"
    t.string   "reserved_column"
    t.integer  "up"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "status"
  end

  add_index "feeds", ["user_id"], name: "index_feeds_on_user_id"

  create_table "in_site_messages", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.string   "msg_content"
    t.integer  "status"
    t.integer  "msg_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "in_site_messages", ["receiver_id"], name: "index_in_site_messages_on_receiver_id"
  add_index "in_site_messages", ["sender_id"], name: "index_in_site_messages_on_sender_id"

  create_table "relationships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "positive_user_id"
    t.integer  "status"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "relationships", ["positive_user_id"], name: "index_relationships_on_positive_user_id"
  add_index "relationships", ["user_id", "positive_user_id"], name: "index_relationships_on_user_id_and_positive_user_id", unique: true
  add_index "relationships", ["user_id"], name: "index_relationships_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "token_digest"
  end

  add_index "users", ["email"], name: "index_users_on_email"

end
