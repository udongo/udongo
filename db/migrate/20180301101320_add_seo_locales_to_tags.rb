class AddSeoLocalesToTags < ActiveRecord::Migration[5.0]
  def change
    add_column :tags, :seo_locales, :text, after: :locales
  end
end
