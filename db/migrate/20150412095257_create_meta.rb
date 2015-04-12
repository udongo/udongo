class CreateMeta < ActiveRecord::Migration
  def change
    create_table :meta do |t|
      t.string :locale
      t.integer :sluggable_id
      t.string :sluggable_type
      t.string :slug
      t.string :title
      t.string :keywords
      t.text :description
      t.text :custom

      t.timestamps null: false
    end

    add_index :meta, :locale
    add_index :meta, :sluggable_id
    add_index :meta, :sluggable_type
    add_index :meta, :slug
  end
end
