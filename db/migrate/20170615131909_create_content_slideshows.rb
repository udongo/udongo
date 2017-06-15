class CreateContentSlideshows < ActiveRecord::Migration[5.0]
  def change
    create_table :content_slideshows do |t|
      t.references :image_collection
      t.boolean :autoplay
      t.integer :slide_interval

      t.timestamps
    end
  end
end
