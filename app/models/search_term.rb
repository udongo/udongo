class SearchTerm < ApplicationRecord
  validates :locale, :term, presence: true
end
