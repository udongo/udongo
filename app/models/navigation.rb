class Navigation < ApplicationRecord
  include Concerns::Cacheable
  cache_by :identifier

  has_many :items, class_name: 'NavigationItem', dependent: :destroy

  validates :description, presence: true
  validates :identifier, presence: true, uniqueness: { case_sensitive: false }
end
