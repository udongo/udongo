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

ActiveRecord::Schema.define(version: 20150412094419) do

  create_table "addresses", force: :cascade do |t|
    t.integer  "addressable_id",   limit: 4
    t.string   "addressable_type", limit: 255
    t.string   "street",           limit: 255
    t.string   "number",           limit: 255
    t.string   "box",              limit: 255
    t.string   "postal",           limit: 255
    t.string   "city",             limit: 255
    t.string   "country",          limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "addresses", ["addressable_id"], name: "index_addresses_on_addressable_id", using: :btree
  add_index "addresses", ["addressable_type"], name: "index_addresses_on_addressable_type", using: :btree

  create_table "admins", force: :cascade do |t|
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id",   limit: 4
    t.string   "commentable_type", limit: 255
    t.string   "locale",           limit: 255
    t.integer  "parent_id",        limit: 4
    t.string   "author",           limit: 255
    t.string   "email",            limit: 255
    t.string   "website",          limit: 255
    t.text     "message",          limit: 65535
    t.string   "status",           limit: 255
    t.boolean  "marked_as_spam",   limit: 1
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree

  create_table "logs", force: :cascade do |t|
    t.string   "category",      limit: 255
    t.integer  "loggable_id",   limit: 4
    t.string   "loggable_type", limit: 255
    t.text     "content",       limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "logs", ["loggable_id"], name: "index_logs_on_loggable_id", using: :btree
  add_index "logs", ["loggable_type"], name: "index_logs_on_loggable_type", using: :btree

  create_table "notes", force: :cascade do |t|
    t.integer  "notable_id",   limit: 4
    t.string   "notable_type", limit: 255
    t.string   "content",      limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "notes", ["notable_id"], name: "index_notes_on_notable_id", using: :btree
  add_index "notes", ["notable_type"], name: "index_notes_on_notable_type", using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "value",       limit: 65535
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "settings", ["name"], name: "index_settings_on_name", using: :btree

end
