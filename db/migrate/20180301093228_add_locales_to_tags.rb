class AddLocalesToTags < ActiveRecord::Migration[5.0]
  def change
    add_column :tags, :locales, :text, after: :id
  end
end
