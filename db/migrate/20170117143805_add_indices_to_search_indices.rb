class AddIndicesToSearchIndices < ActiveRecord::Migration[5.0]
  def change
    add_index :search_indices, [:searchable_type, :searchable_id]
    add_index :search_indices, [:locale, :key]
  end
end
