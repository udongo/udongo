class CreateContentVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :content_videos do |t|
      t.text :url
      t.string :aspect_ratio

      t.timestamps
    end
  end
end
