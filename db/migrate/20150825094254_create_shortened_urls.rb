class CreateShortenedUrls < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.string :code
      t.string :url
      t.integer :times_used

      t.timestamps null: false
    end
  end
end
