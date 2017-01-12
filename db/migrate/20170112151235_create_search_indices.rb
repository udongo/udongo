class CreateSearchIndices < ActiveRecord::Migration[5.0]
  def change
    create_table :search_indices do |t|
      t.string :searchable_type
      t.integer :searchable_id
      t.string :locale
      t.string :key
      t.text :value

      t.timestamps
    end
  end
end
