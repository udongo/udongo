class RemoveContentImages < ActiveRecord::Migration[5.0]
  def change
    drop_table :content_images
  end
end
