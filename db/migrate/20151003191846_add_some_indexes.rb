class AddSomeIndexes < ActiveRecord::Migration
  def change
    add_index :comments, :locale
    add_index :comments, :parent_id
    add_index :comments, :status
    add_index :content_columns, :row_id
    add_index :content_columns, :position
    add_index :content_rows, :locale
    add_index :content_rows, :position
    add_index :logs, :category
    add_index :pages, :identifier
    add_index :pages, :position
    add_index :redirects, :source_uri
  end
end
