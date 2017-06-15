class RenameAssetCollectionToImageCollection < ActiveRecord::Migration[5.0]
  def change
    rename_table :asset_collections, :image_collections
  end
end
