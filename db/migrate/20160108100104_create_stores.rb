class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :storable_type, index: true
      t.integer :storable_id, index: true
      t.string :name
      t.text :value
      t.string :klass

      t.timestamps null: false
    end
  end
end
