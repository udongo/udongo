class AddCategoryToAdmin < ActiveRecord::Migration[5.0]
  def change
    add_column :addresses, :category, :string, after: 'addressable_type'
  end
end
