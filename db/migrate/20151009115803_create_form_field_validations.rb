class CreateFormFieldValidations < ActiveRecord::Migration
  def change
    create_table :form_field_validations do |t|
      t.references :form_field, index: true
      t.string :validation_class
      t.integer :position

      t.timestamps null: false
    end
  end
end
