class Article < ApplicationRecord
  include Concerns::Taggable
  include Concerns::Visible
  include Concerns::Seo
  include Concerns::FlexibleContent
  include Concerns::Publishable
  include Concerns::Imageable

  include Concerns::Searchable
  searchable_fields :title, :summary, :flexible_content

  include Concerns::Translatable
  translatable_fields :title, :summary

  belongs_to :user
end
