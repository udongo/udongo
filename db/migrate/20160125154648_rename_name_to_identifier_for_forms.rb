class RenameNameToIdentifierForForms < ActiveRecord::Migration
  def change
    rename_column :forms, :name, :identifier
  end
end
