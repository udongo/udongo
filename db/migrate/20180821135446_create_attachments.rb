class CreateAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :attachments do |t|
      t.string :attachable_type
      t.integer :attachable_id
      t.references :asset
      t.integer :position
      t.boolean :visible
      t.string :locale

      t.timestamps
    end

    add_index :attachments, [:attachable_type, :attachable_id], name: 'attachable_idx'
    add_index :attachments, :position, name: 'attachable_position_idx'
    add_index :attachments, :visible, name: 'attachable_visible_idx'
    add_index :attachments, :locale, name: 'attachable_locale_idx'
  end
end
