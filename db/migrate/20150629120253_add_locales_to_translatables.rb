class AddLocalesToTranslatables < ActiveRecord::Migration
  def change
    add_column :pages, :locales, :text, after: 'draggable'
  end
end
