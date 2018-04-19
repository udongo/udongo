class AddTargetToContentPicture < ActiveRecord::Migration[5.0]
  def change
    add_column :content_pictures, :target, :string, after: 'url'
  end
end
