class SearchIndex < ApplicationRecord
  belongs_to :searchable, polymorphic: true

  validates :locale, :name, presence: true
end
