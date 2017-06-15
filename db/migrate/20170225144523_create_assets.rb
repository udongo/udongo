class CreateAssets < ActiveRecord::Migration[5.0]
  def change
    create_table :assets do |t|
      t.string :filename
      t.string :content_type
      t.integer :filesize
      t.text :description

      t.timestamps
    end

    add_index :assets, :content_type
  end
end
