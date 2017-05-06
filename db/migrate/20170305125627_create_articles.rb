class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.references :user
      t.boolean :press_release
      t.datetime :published_at
      t.text :locales
      t.boolean :visible

      t.timestamps
    end

    add_index :articles, :press_release
    add_index :articles, :visible
    add_index :articles, :published_at
  end
end
