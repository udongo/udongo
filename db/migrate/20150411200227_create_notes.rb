class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :notable_id
      t.string :notable_type
      t.string :content

      t.timestamps null: false
    end

    add_index :notes, :notable_id
    add_index :notes, :notable_type
  end
end
