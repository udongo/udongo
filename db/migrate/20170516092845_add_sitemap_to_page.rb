class AddSitemapToPage < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :sitemap, :boolean, after: 'content_disabled'
    add_index :pages, :sitemap
  end
end
