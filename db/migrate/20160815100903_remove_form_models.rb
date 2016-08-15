class RemoveFormModels < ActiveRecord::Migration#[5.0]
  def change
    drop_table :forms
    drop_table :form_fields
    drop_table :form_field_validations
    drop_table :form_submissions
    drop_table :form_submission_data
  end
end
