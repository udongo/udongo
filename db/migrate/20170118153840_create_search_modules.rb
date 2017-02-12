class CreateSearchModules < ActiveRecord::Migration[5.0]
  def change
    create_table :search_modules do |t|
      t.string :name
      t.boolean :searchable
      t.integer :weight

      t.timestamps
    end

    add_index :search_modules, [:name, :searchable]
  end
end
