class AddExternalRefToFormField < ActiveRecord::Migration[5.0]
  def change
    add_column :form_fields, :external_reference, :string, after: 'email'
    add_index :form_fields, :external_reference
  end
end
