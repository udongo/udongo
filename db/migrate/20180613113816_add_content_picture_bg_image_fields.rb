class AddContentPictureBgImageFields < ActiveRecord::Migration[5.0]
  def change
    add_column :content_pictures, :background_image, :boolean, after: 'target'
    add_column :content_pictures, :min_height, :integer, after: 'disallow_resize'
  end
end
