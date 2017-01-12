class SearchIndex < ApplicationRecord
  include Concerns::Locale

  belongs_to :searchable, polymorphic: true

  validates :searchable_id, :searchable_type, :locale, :key, :value,
    presence: true
end
