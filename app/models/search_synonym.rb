class SearchSynonym < ApplicationRecord
  validates :locale, :term, :synonyms, presence: true

  validates :term, uniqueness: { case_sensitive: false, scope: :locale }
end
