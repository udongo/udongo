class CreateNavigationItems < ActiveRecord::Migration
  def change
    create_table :navigation_items do |t|
      t.references :navigation, index: true
      t.references :page, index: true
      t.text :locales
      t.integer :position

      t.timestamps null: false
    end
  end
end
