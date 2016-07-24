class Snippet < ApplicationRecord
  include Concerns::Translatable
  translatable_fields :title, :content

  include Concerns::Cacheable
  cache_by :identifier

  validates :description, presence: true
  validates :identifier, presence: true, uniqueness: { case_sensitive: false }
end
