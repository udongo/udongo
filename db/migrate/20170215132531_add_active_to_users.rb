class AddActiveToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :active, :boolean, after: 'email'
    add_index :users, :active
  end
end
