class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :category
      t.integer :loggable_id
      t.string :loggable_type
      t.text :content

      t.timestamps null: false
    end

    add_index :logs, :loggable_id
    add_index :logs, :loggable_type
  end
end
