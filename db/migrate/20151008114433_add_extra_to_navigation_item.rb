class AddExtraToNavigationItem < ActiveRecord::Migration
  def change
    add_column :navigation_items, :extra, :string
  end
end
