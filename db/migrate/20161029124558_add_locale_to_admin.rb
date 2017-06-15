class AddLocaleToAdmin < ActiveRecord::Migration[5.0]
  def change
    add_column :admins, :locale, :string, after: 'id'
    add_index :admins, :locale
  end
end
