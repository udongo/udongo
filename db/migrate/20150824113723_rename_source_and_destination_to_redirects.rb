class RenameSourceAndDestinationToRedirects < ActiveRecord::Migration
  def change
    rename_column :redirects, :source, :source_uri
    rename_column :redirects, :destination, :destination_uri
  end
end
