class SearchIndex < ApplicationRecord
  belongs_to :searchable, polymorphic: true

  validates :locale, :key, presence: true
end
