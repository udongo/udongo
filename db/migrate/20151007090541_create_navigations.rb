class CreateNavigations < ActiveRecord::Migration
  def change
    create_table :navigations do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
