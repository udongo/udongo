class CreateContentPictures < ActiveRecord::Migration[5.0]
  def change
    create_table :content_pictures do |t|
      t.references :asset
      t.text :caption
      t.text :url

      t.timestamps
    end
  end
end
