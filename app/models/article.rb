class Article < ApplicationRecord
  include Concerns::Taggable
  include Concerns::Visible
  include Concerns::Seo
  include Concerns::FlexibleContent
  include Concerns::Searchable

  include Concerns::Translatable
  translatable_fields :title, :summary

  belongs_to :user
end
