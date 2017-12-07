class RenameCustomToCustomHeadForMeta < ActiveRecord::Migration[5.0]
  def change
    rename_column :meta, :custom, :custom_head
  end
end
