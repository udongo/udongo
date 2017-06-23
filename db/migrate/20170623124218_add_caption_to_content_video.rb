class AddCaptionToContentVideo < ActiveRecord::Migration[5.0]
  def change
    add_column :content_videos, :caption, :text, after: 'url'
  end
end
