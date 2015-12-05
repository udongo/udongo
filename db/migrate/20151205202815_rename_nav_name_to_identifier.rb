class RenameNavNameToIdentifier < ActiveRecord::Migration
  def change
    rename_column :navigations, :name, :identifier
  end
end
