class AddEditableContentToPage < ActiveRecord::Migration
  def change
    add_column :pages, :content_disabled, :boolean, after: 'draggable'
  end
end
