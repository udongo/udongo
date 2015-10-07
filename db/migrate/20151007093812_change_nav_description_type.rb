class ChangeNavDescriptionType < ActiveRecord::Migration
  def change
    change_column :navigations, :description, :string
  end
end
