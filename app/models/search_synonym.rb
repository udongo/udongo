class SearchSynonym < ApplicationRecord
  validates :locale, :term, :synonyms, presence: true
end
