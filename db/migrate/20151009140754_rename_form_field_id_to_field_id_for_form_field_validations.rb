class RenameFormFieldIdToFieldIdForFormFieldValidations < ActiveRecord::Migration
  def change
    rename_column :form_field_validations, :form_field_id, :field_id
  end
end
