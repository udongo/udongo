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

ActiveRecord::Schema.define(version: 20181129141539) do

  create_table "addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.string   "category"
    t.string   "street"
    t.string   "number"
    t.string   "box"
    t.string   "postal"
    t.string   "city"
    t.string   "country"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["addressable_id"], name: "index_addresses_on_addressable_id", using: :btree
    t.index ["addressable_type"], name: "index_addresses_on_addressable_type", using: :btree
  end

  create_table "admins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "locale"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["locale"], name: "index_admins_on_locale", using: :btree
  end

  create_table "articles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.boolean  "press_release"
    t.datetime "published_at"
    t.text     "locales",       limit: 65535
    t.text     "seo_locales",   limit: 65535
    t.boolean  "visible"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["press_release"], name: "index_articles_on_press_release", using: :btree
    t.index ["published_at"], name: "index_articles_on_published_at", using: :btree
    t.index ["user_id"], name: "index_articles_on_user_id", using: :btree
    t.index ["visible"], name: "index_articles_on_visible", using: :btree
  end

  create_table "assets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "filename"
    t.string   "content_type"
    t.integer  "filesize"
    t.text     "description",  limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["content_type"], name: "index_assets_on_content_type", using: :btree
  end

  create_table "attachments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "attachable_type"
    t.integer  "attachable_id"
    t.integer  "asset_id"
    t.integer  "position"
    t.boolean  "visible"
    t.string   "locale"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["asset_id"], name: "index_attachments_on_asset_id", using: :btree
    t.index ["attachable_type", "attachable_id"], name: "attachable_idx", using: :btree
    t.index ["locale"], name: "attachable_locale_idx", using: :btree
    t.index ["position"], name: "attachable_position_idx", using: :btree
    t.index ["visible"], name: "attachable_visible_idx", using: :btree
  end

  create_table "ckeditor_assets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
    t.index ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "locale"
    t.integer  "parent_id"
    t.string   "author"
    t.string   "email"
    t.string   "website"
    t.text     "message",          limit: 65535
    t.string   "status"
    t.boolean  "marked_as_spam"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
    t.index ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
    t.index ["locale"], name: "index_comments_on_locale", using: :btree
    t.index ["parent_id"], name: "index_comments_on_parent_id", using: :btree
    t.index ["status"], name: "index_comments_on_status", using: :btree
  end

  create_table "content_columns", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "row_id"
    t.integer  "width_md"
    t.integer  "width_lg"
    t.integer  "width_xl"
    t.integer  "width_xs"
    t.integer  "width_sm"
    t.integer  "position"
    t.string   "content_type"
    t.integer  "content_id"
    t.string   "external_reference"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["content_id"], name: "idx_content_columns_on_content_id", using: :btree
    t.index ["content_type"], name: "idx_content_columns_on_content_type", using: :btree
    t.index ["external_reference"], name: "index_content_columns_on_external_reference", using: :btree
    t.index ["position"], name: "index_content_columns_on_position", using: :btree
    t.index ["row_id"], name: "index_content_columns_on_row_id", using: :btree
  end

  create_table "content_forms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "form_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_id"], name: "index_content_forms_on_form_id", using: :btree
  end

  create_table "content_pictures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "asset_id"
    t.text     "caption",          limit: 65535
    t.text     "url",              limit: 65535
    t.string   "target"
    t.boolean  "background_image"
    t.boolean  "disallow_resize"
    t.integer  "min_height"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["asset_id"], name: "index_content_pictures_on_asset_id", using: :btree
  end

  create_table "content_rows", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "locale"
    t.string   "rowable_type"
    t.integer  "rowable_id"
    t.boolean  "full_width"
    t.string   "horizontal_alignment"
    t.string   "vertical_alignment"
    t.string   "background_color"
    t.boolean  "no_gutters"
    t.integer  "padding_top"
    t.integer  "padding_bottom"
    t.integer  "margin_top"
    t.integer  "margin_bottom"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["locale"], name: "index_content_rows_on_locale", using: :btree
    t.index ["position"], name: "index_content_rows_on_position", using: :btree
    t.index ["rowable_id"], name: "idx_content_rows_on_rowable_id", using: :btree
    t.index ["rowable_type"], name: "idx_content_rows_on_rowable_type", using: :btree
  end

  create_table "content_slideshows", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "image_collection_id"
    t.boolean  "autoplay"
    t.integer  "slide_interval"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["image_collection_id"], name: "index_content_slideshows_on_image_collection_id", using: :btree
  end

  create_table "content_texts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "content",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "content_videos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "url",          limit: 65535
    t.text     "caption",      limit: 65535
    t.string   "aspect_ratio"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "email_templates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "identifier"
    t.string   "description"
    t.text     "locales",     limit: 65535
    t.string   "from_name"
    t.string   "from_email"
    t.string   "cc"
    t.string   "bcc"
    t.boolean  "optional"
    t.text     "vars",        limit: 65535
    t.integer  "position"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["identifier"], name: "index_email_templates_on_identifier", using: :btree
  end

  create_table "emails", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "from_name"
    t.string   "from_email"
    t.string   "to_name"
    t.string   "to_email"
    t.string   "cc"
    t.string   "bcc"
    t.string   "subject"
    t.text     "plain_content", limit: 16777215
    t.text     "html_content",  limit: 16777215
    t.string   "locale"
    t.text     "attachments",   limit: 65535
    t.datetime "sent_at"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "form_fields", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "form_id"
    t.text     "locales",            limit: 65535
    t.string   "identifier"
    t.string   "field_type"
    t.boolean  "presence"
    t.boolean  "email"
    t.string   "external_reference"
    t.integer  "position"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["external_reference"], name: "index_form_fields_on_external_reference", using: :btree
    t.index ["form_id"], name: "index_form_fields_on_form_id", using: :btree
  end

  create_table "form_submission_data", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "form_submission_id"
    t.string   "name"
    t.text     "value",              limit: 65535
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["form_submission_id"], name: "index_form_submission_data_on_form_submission_id", using: :btree
  end

  create_table "form_submissions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "form_id"
    t.text     "extra_info", limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["form_id"], name: "index_form_submissions_on_form_id", using: :btree
  end

  create_table "forms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "locales",     limit: 65535
    t.string   "identifier"
    t.string   "description"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["identifier"], name: "index_forms_on_identifier", using: :btree
  end

  create_table "image_collections", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "identifier"
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["identifier"], name: "index_image_collections_on_identifier", using: :btree
  end

  create_table "images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.integer  "asset_id"
    t.integer  "position"
    t.boolean  "visible"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["asset_id"], name: "index_images_on_asset_id", using: :btree
    t.index ["imageable_id"], name: "index_images_on_imageable_id", using: :btree
    t.index ["imageable_type"], name: "index_images_on_imageable_type", using: :btree
    t.index ["position"], name: "index_images_on_position", using: :btree
    t.index ["visible"], name: "index_images_on_visible", using: :btree
  end

  create_table "logs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "category"
    t.integer  "loggable_id"
    t.string   "loggable_type"
    t.text     "content",       limit: 65535
    t.text     "data",          limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["category"], name: "index_logs_on_category", using: :btree
    t.index ["loggable_id"], name: "index_logs_on_loggable_id", using: :btree
    t.index ["loggable_type"], name: "index_logs_on_loggable_type", using: :btree
  end

  create_table "meta", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "locale"
    t.integer  "sluggable_id"
    t.string   "sluggable_type"
    t.string   "slug"
    t.string   "title"
    t.string   "keywords"
    t.text     "description",    limit: 65535
    t.text     "custom",         limit: 65535
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["locale"], name: "index_meta_on_locale", using: :btree
    t.index ["slug"], name: "index_meta_on_slug", using: :btree
    t.index ["sluggable_id"], name: "index_meta_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_meta_on_sluggable_type", using: :btree
  end

  create_table "navigation_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "navigation_id"
    t.integer  "page_id"
    t.text     "locales",       limit: 65535
    t.integer  "position"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "extra"
    t.index ["navigation_id"], name: "index_navigation_items_on_navigation_id", using: :btree
    t.index ["page_id"], name: "index_navigation_items_on_page_id", using: :btree
    t.index ["position"], name: "index_navigation_items_on_position", using: :btree
  end

  create_table "navigations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "identifier"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "notes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "notable_id"
    t.string   "notable_type"
    t.string   "content"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["notable_id"], name: "index_notes_on_notable_id", using: :btree
    t.index ["notable_type"], name: "index_notes_on_notable_type", using: :btree
  end

  create_table "pages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "identifier"
    t.string   "description"
    t.integer  "parent_id"
    t.integer  "position"
    t.boolean  "visible"
    t.boolean  "deletable"
    t.boolean  "draggable"
    t.boolean  "content_disabled"
    t.boolean  "sitemap"
    t.text     "locales",          limit: 65535
    t.text     "seo_locales",      limit: 65535
    t.string   "route"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["identifier"], name: "index_pages_on_identifier", using: :btree
    t.index ["parent_id"], name: "index_page_parent_id", using: :btree
    t.index ["position"], name: "index_pages_on_position", using: :btree
    t.index ["sitemap"], name: "index_pages_on_sitemap", using: :btree
    t.index ["visible"], name: "index_pages_on_visible", using: :btree
  end

  create_table "queued_tasks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "klass"
    t.text     "data",       limit: 65535
    t.boolean  "locked"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["locked"], name: "index_queued_tasks_on_locked", using: :btree
  end

  create_table "redirects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "source_uri"
    t.string   "destination_uri"
    t.integer  "status_code"
    t.boolean  "disabled"
    t.integer  "times_used"
    t.integer  "depth"
    t.boolean  "working"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["source_uri"], name: "index_redirects_on_source_uri", using: :btree
  end

  create_table "search_indices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "searchable_type"
    t.integer  "searchable_id"
    t.string   "locale"
    t.string   "name"
    t.text     "value",           limit: 65535
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["locale", "name"], name: "index_search_indices_on_locale_and_name", using: :btree
    t.index ["searchable_type", "searchable_id"], name: "index_search_indices_on_searchable_type_and_searchable_id", using: :btree
  end

  create_table "search_modules", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.boolean  "searchable"
    t.integer  "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "searchable"], name: "index_search_modules_on_name_and_searchable", using: :btree
  end

  create_table "search_synonyms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "locale"
    t.string   "term"
    t.text     "synonyms",   limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["locale"], name: "index_search_synonyms_on_locale", using: :btree
    t.index ["term"], name: "index_search_synonyms_on_term", using: :btree
  end

  create_table "search_terms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "locale"
    t.string   "term"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "value",       limit: 65535
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["name"], name: "index_settings_on_name", using: :btree
  end

  create_table "snippets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "identifier"
    t.string   "description"
    t.boolean  "title_disabled"
    t.boolean  "allow_html_in_title"
    t.boolean  "content_disabled"
    t.boolean  "allow_html_in_content"
    t.boolean  "editor_for_content"
    t.text     "locales",               limit: 65535
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["identifier"], name: "index_snippets_on_identifier", using: :btree
  end

  create_table "stores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "storable_type"
    t.integer  "storable_id"
    t.string   "collection"
    t.string   "name"
    t.text     "value",         limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["collection", "storable_id", "storable_type"], name: "idx_storable", using: :btree
    t.index ["collection"], name: "index_stores_on_collection", using: :btree
    t.index ["storable_id"], name: "index_stores_on_storable_id", using: :btree
    t.index ["storable_type"], name: "index_stores_on_storable_type", using: :btree
  end

  create_table "tagged_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["tag_id"], name: "index_tagged_items_on_tag_id", using: :btree
    t.index ["taggable_id"], name: "index_tagged_items_on_taggable_id", using: :btree
    t.index ["taggable_type"], name: "index_tagged_items_on_taggable_type", using: :btree
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "locale"
    t.string   "name"
    t.string   "seo_slug"
    t.text     "seo_title",          limit: 65535
    t.text     "seo_description",    limit: 65535
    t.string   "seo_keywords"
    t.text     "seo_custom",         limit: 65535
    t.string   "external_reference"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["external_reference"], name: "index_tags_on_external_reference", using: :btree
    t.index ["locale"], name: "index_tags_on_locale", using: :btree
    t.index ["name"], name: "index_tags_on_name", using: :btree
    t.index ["seo_slug"], name: "index_tags_on_seo_slug", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.boolean  "active"
    t.integer  "login_count"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "password_digest"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["active"], name: "index_users_on_active", using: :btree
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree
  end

end
