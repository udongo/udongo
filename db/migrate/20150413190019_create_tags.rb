class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :locale
      t.string :name
      t.string :slug

      t.timestamps null: false
    end

    add_index :tags, :locale
    add_index :tags, :name
    add_index :tags, :slug
  end
end
