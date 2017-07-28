class AddSeoLocalesToModelsWithSeo < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :seo_locales, :text, after: 'locales'
    add_column :articles, :seo_locales, :text, after: 'locales'
  end
end
