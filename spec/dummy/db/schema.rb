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

ActiveRecord::Schema.define(version: 20150826084234) do

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

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.integer  "assetable_id",      limit: 4
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

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

  create_table "content_columns", force: :cascade do |t|
    t.integer  "row_id",       limit: 4
    t.integer  "width",        limit: 4
    t.integer  "position",     limit: 4
    t.string   "content_type", limit: 255
    t.integer  "content_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "content_columns", ["content_id"], name: "idx_content_columns_on_content_id", using: :btree
  add_index "content_columns", ["content_type"], name: "idx_content_columns_on_content_type", using: :btree

  create_table "content_images", force: :cascade do |t|
    t.string   "file",       limit: 255
    t.text     "caption",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "url",        limit: 65535
  end

  create_table "content_rows", force: :cascade do |t|
    t.string   "locale",       limit: 255
    t.string   "rowable_type", limit: 255
    t.integer  "rowable_id",   limit: 4
    t.integer  "position",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "content_rows", ["rowable_id"], name: "idx_content_rows_on_rowable_id", using: :btree
  add_index "content_rows", ["rowable_type"], name: "idx_content_rows_on_rowable_type", using: :btree

  create_table "content_texts", force: :cascade do |t|
    t.text     "content",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "meta", force: :cascade do |t|
    t.string   "locale",         limit: 255
    t.integer  "sluggable_id",   limit: 4
    t.string   "sluggable_type", limit: 255
    t.string   "slug",           limit: 255
    t.string   "title",          limit: 255
    t.string   "keywords",       limit: 255
    t.text     "description",    limit: 65535
    t.text     "custom",         limit: 65535
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "meta", ["locale"], name: "index_meta_on_locale", using: :btree
  add_index "meta", ["slug"], name: "index_meta_on_slug", using: :btree
  add_index "meta", ["sluggable_id"], name: "index_meta_on_sluggable_id", using: :btree
  add_index "meta", ["sluggable_type"], name: "index_meta_on_sluggable_type", using: :btree

  create_table "notes", force: :cascade do |t|
    t.integer  "notable_id",   limit: 4
    t.string   "notable_type", limit: 255
    t.string   "content",      limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "notes", ["notable_id"], name: "index_notes_on_notable_id", using: :btree
  add_index "notes", ["notable_type"], name: "index_notes_on_notable_type", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "identifier",  limit: 255
    t.string   "description", limit: 255
    t.integer  "parent_id",   limit: 4
    t.integer  "position",    limit: 4
    t.boolean  "visible",     limit: 1
    t.boolean  "deletable",   limit: 1
    t.boolean  "draggable",   limit: 1
    t.text     "locales",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["parent_id"], name: "index_page_parent_id", using: :btree

  create_table "redirects", force: :cascade do |t|
    t.string   "source_uri",      limit: 255
    t.string   "destination_uri", limit: 255
    t.integer  "status_code",     limit: 4
    t.boolean  "disabled",        limit: 1
    t.integer  "times_used",      limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "settings", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "value",       limit: 65535
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "settings", ["name"], name: "index_settings_on_name", using: :btree

  create_table "snippets", force: :cascade do |t|
    t.string   "identifier",   limit: 255
    t.string   "description",  limit: 255
    t.boolean  "html_title",   limit: 1
    t.boolean  "html_content", limit: 1
    t.text     "locales",      limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "snippets", ["identifier"], name: "index_snippets_on_identifier", using: :btree

  create_table "tagged_items", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "tagged_items", ["tag_id"], name: "index_tagged_items_on_tag_id", using: :btree
  add_index "tagged_items", ["taggable_id"], name: "index_tagged_items_on_taggable_id", using: :btree
  add_index "tagged_items", ["taggable_type"], name: "index_tagged_items_on_taggable_type", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "locale",     limit: 255
    t.string   "name",       limit: 255
    t.string   "slug",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "tags", ["locale"], name: "index_tags_on_locale", using: :btree
  add_index "tags", ["name"], name: "index_tags_on_name", using: :btree
  add_index "tags", ["slug"], name: "index_tags_on_slug", using: :btree

  create_table "translations", force: :cascade do |t|
    t.integer  "translatable_id",   limit: 4
    t.string   "translatable_type", limit: 255
    t.string   "locale",            limit: 255
    t.string   "name",              limit: 255
    t.text     "value",             limit: 65535
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "translations", ["translatable_id", "translatable_type", "locale", "name"], name: "idx_translations_magic", using: :btree

end
