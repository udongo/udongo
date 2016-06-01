class AddCollectionToStore < ActiveRecord::Migration
  def change
    add_column :stores, :collection, :string, after: 'storable_id'
    add_index :stores, :collection
  end
end
