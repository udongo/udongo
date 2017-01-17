class SearchIndex < ApplicationRecord
  include Concerns::Locale

  belongs_to :searchable, polymorphic: true

  validates :searchable_id, :searchable_type, :locale, :key, presence: true
end
