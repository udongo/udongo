class ContentTables < ActiveRecord::Migration
  def change
    create_table "content_columns", force: true do |t|
      t.integer  "row_id"
      t.integer  "width"
      t.integer  "position"
      t.string   "content_type"
      t.integer  "content_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "content_columns", ["content_id"], name: "idx_content_columns_on_content_id", using: :btree
    add_index "content_columns", ["content_type"], name: "idx_content_columns_on_content_type", using: :btree

    create_table "content_images", force: true do |t|
      t.string   "file"
      t.text     "caption"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.text     "url"
    end

    create_table "content_rows", force: true do |t|
      t.string   "locale"
      t.string   "rowable_type"
      t.integer  "rowable_id"
      t.integer  "position"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "content_rows", ["rowable_id"], name: "idx_content_rows_on_rowable_id", using: :btree
    add_index "content_rows", ["rowable_type"], name: "idx_content_rows_on_rowable_type", using: :btree

    create_table "content_texts", force: true do |t|
      t.text     "content"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
