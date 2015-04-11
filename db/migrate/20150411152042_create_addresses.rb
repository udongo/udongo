class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :addressable_id
      t.string :addressable_type
      t.string :street
      t.string :number
      t.string :box
      t.string :postal
      t.string :city
      t.string :country

      t.timestamps null: false
    end

    add_index :addresses, :addressable_type
    add_index :addresses, :addressable_id
  end
end
