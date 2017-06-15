class RenameKeyToNameForSearchIndices < ActiveRecord::Migration[5.0]
  def change
    rename_column :search_indices, :key, :name
  end
end
