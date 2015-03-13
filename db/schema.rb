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

ActiveRecord::Schema.define(version: 20150313192527) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "connections", force: true do |t|
    t.integer  "sender_id",   null: false
    t.integer  "receiver_id", null: false
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "connections", ["receiver_id"], name: "index_connections_on_receiver_id", using: :btree
  add_index "connections", ["sender_id"], name: "index_connections_on_sender_id", using: :btree

  create_table "experiences", force: true do |t|
    t.integer  "user_id",         null: false
    t.integer  "experience_type", null: false
    t.string   "role"
    t.string   "institution"
    t.string   "location"
    t.text     "description"
    t.date     "start_date",      null: false
    t.date     "end_date"
    t.string   "field"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "experiences", ["experience_type"], name: "index_experiences_on_experience_type", using: :btree
  add_index "experiences", ["user_id"], name: "index_experiences_on_user_id", using: :btree

  create_table "pg_search_documents", force: true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "user_connections", force: true do |t|
    t.integer "user_id",       null: false
    t.integer "connection_id", null: false
  end

  add_index "user_connections", ["connection_id", "user_id"], name: "index_user_connections_on_connection_id_and_user_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                null: false
    t.string   "password_digest",      null: false
    t.string   "session_token",        null: false
    t.string   "fname"
    t.string   "lname"
    t.string   "location"
    t.string   "tagline"
    t.string   "industry"
    t.date     "date_of_birth"
    t.text     "summary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["session_token"], name: "index_users_on_session_token", unique: true, using: :btree

end
