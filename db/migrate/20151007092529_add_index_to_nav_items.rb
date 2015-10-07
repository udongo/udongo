class AddIndexToNavItems < ActiveRecord::Migration
  def change
    add_index :navigation_items, :position
  end
end
