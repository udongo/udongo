class AddNoGuttersToContentRow < ActiveRecord::Migration[5.0]
  def change
    add_column :content_rows, :no_gutters, :boolean, after: 'background_color'
  end
end
