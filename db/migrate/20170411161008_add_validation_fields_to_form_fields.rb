class AddValidationFieldsToFormFields < ActiveRecord::Migration[5.0]
  def change
    add_column :form_fields, :presence, :boolean, after: :field_type
    add_column :form_fields, :email, :boolean, after: :presence
  end
end
