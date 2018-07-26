class SearchModule < ApplicationRecord
  scope :weighted, -> { order('weight DESC') }

  validates :name, presence: true

  def indices
    SearchIndex.joins('INNER JOIN search_modules ON search_indices.searchable_type = search_modules.name')
               .where('search_modules.name = ?', name)
  end
end
