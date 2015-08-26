class CreateRedirects < ActiveRecord::Migration
  def change
    create_table :redirects do |t|
      t.string :source
      t.string :destination
      t.integer :status_code
      t.boolean :disabled

      t.timestamps null: false
    end
  end
end
