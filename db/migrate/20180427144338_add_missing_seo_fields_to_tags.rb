class AddMissingSeoFieldsToTags < ActiveRecord::Migration[5.0]
  def change
    rename_column :tags, :slug, :seo_slug
    add_column :tags, :seo_title, :text, after: :seo_slug
    add_column :tags, :seo_description, :text, after: :seo_title
    add_column :tags, :seo_keywords, :string, after: :seo_description
    add_column :tags, :seo_custom, :text, after: :seo_keywords
  end
end
