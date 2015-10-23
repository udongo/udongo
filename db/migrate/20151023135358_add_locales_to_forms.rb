class AddLocalesToForms < ActiveRecord::Migration
  def change
    add_column :forms, :locales, :text, after: :id
  end
end
