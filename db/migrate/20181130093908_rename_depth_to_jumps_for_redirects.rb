class RenameDepthToJumpsForRedirects < ActiveRecord::Migration[5.0]
  def change
    rename_column :redirects, :depth, :jumps
  end
end
