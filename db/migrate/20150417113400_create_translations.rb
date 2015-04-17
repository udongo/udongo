class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.integer :translatable_id
      t.string :translatable_type
      t.string :locale
      t.string :name
      t.text :value

      t.timestamps null: false
    end

    add_index :translations, [:translatable_id, :translatable_type, :locale, :name], name: 'idx_translations_magic'
  end
end
