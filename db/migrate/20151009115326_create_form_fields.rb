class CreateFormFields < ActiveRecord::Migration
  def change
    create_table :form_fields do |t|
      t.references :form, index: true
      t.string :name
      t.string :field_type
      t.integer :position

      t.timestamps null: false
    end
  end
end
