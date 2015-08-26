class RemoveShortenedUrls < ActiveRecord::Migration
  def change
    drop_table :shortened_urls
  end
end
