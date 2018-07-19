class CreateSearches < ActiveRecord::Migration[5.0]
  def change
    create_table :searches do |t|
      t.string :locale
      t.string :term

      t.timestamps
    end
  end
end
