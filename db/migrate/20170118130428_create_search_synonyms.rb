class CreateSearchSynonyms < ActiveRecord::Migration[5.0]
  def change
    create_table :search_synonyms do |t|
      t.string :locale, index: true
      t.string :term, index: true
      t.text :synonyms

      t.timestamps
    end
  end
end
