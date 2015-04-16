class CreateTaggedItems < ActiveRecord::Migration
  def change
    create_table :tagged_items do |t|
      t.references :tag, index: true, foreign_key: true
      t.integer :taggable_id
      t.string :taggable_type

      t.timestamps null: false
    end

    add_index :tagged_items, :taggable_id
    add_index :tagged_items, :taggable_type
  end
end
