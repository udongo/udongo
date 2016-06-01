class RemoveKlassFromStores < ActiveRecord::Migration
  def change
    remove_column :stores, :klass
    add_index :stores, [:collection, :storable_id, :storable_type], name: 'idx_storable'
  end
end
