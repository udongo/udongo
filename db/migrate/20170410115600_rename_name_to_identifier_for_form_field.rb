class RenameNameToIdentifierForFormField < ActiveRecord::Migration[5.0]
  def change
    rename_column :form_fields, :name, :identifier
  end
end
