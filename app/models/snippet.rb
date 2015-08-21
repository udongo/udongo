class Snippet < ActiveRecord::Base
  include Concerns::Translatable
  include Concerns::Cacheable
  cache_by :identifier

  translatable_fields :title, :content

  validates :description, presence: true
  validates :identifier, presence: true, uniqueness: { case_sensitive: false }
end
