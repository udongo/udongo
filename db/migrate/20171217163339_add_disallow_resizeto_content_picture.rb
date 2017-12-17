class AddDisallowResizetoContentPicture < ActiveRecord::Migration[5.0]
  def change
    add_column :content_pictures, :disallow_resize, :boolean, after: 'url'
  end
end
