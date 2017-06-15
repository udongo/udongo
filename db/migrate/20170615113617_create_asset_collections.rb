class CreateAssetCollections < ActiveRecord::Migration[5.0]
  def change
    create_table :asset_collections do |t|
      t.string :identifier
      t.text :description

      t.timestamps
    end

    add_index :asset_collections, :identifier
  end
end
