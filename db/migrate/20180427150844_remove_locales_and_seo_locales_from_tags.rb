class RemoveLocalesAndSeoLocalesFromTags < ActiveRecord::Migration[5.0]
  def change
    remove_column :tags, :locales
    remove_column :tags, :seo_locales
  end
end
