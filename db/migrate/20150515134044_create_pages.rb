class CreatePages < ActiveRecord::Migration
  def up
    create_table :pages do |t|
      t.string :identifier
      t.string :description
      t.integer :parent_id
      t.integer :position
      t.boolean :visible
      t.boolean :deletable
      t.boolean :draggable
      t.boolean :trashed

      t.timestamps
    end

    add_index :pages, :parent_id, name: :index_page_parent_id, using: :btree
  end

  def down
    drop_table :pages
  end
end
