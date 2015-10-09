class AddLocalesToFormFieldValidations < ActiveRecord::Migration
  def change
    add_column :form_field_validations, :locales, :text, after: :field_id
  end
end
