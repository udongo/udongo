class CreateEmailTemplates < ActiveRecord::Migration
  def change
    create_table :email_templates do |t|
      t.string :identifier
      t.string :description
      t.text :locales
      t.string :from_name
      t.string :from_email
      t.boolean :optional
      t.text :vars
      t.integer :position

      t.timestamps null: false
    end

    add_index :email_templates, :identifier
  end
end
