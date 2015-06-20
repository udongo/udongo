class RemoveTrashedFromPage < ActiveRecord::Migration
  def change
    remove_column :pages, :trashed
  end
end
