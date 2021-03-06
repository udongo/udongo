class ImageCollection < ApplicationRecord
  include Concerns::Imageable

  include Concerns::Cacheable
  cache_by :identifier

  validates :description, presence: true
  validates :identifier, uniqueness: { case_sensitive: false }, allow_blank: true
end
