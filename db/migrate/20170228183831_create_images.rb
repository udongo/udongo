class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.integer :imageable_id
      t.string :imageable_type
      t.references :asset
      t.integer :position
      t.boolean :visible

      t.timestamps
    end

    add_index :images, :imageable_id
    add_index :images, :imageable_type
    add_index :images, :position
    add_index :images, :visible
  end
end
