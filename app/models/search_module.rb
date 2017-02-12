class SearchModule < ApplicationRecord
  validates :name, presence: true

  scope :weighted, -> { order('weight DESC') }

  def indices
    SearchIndex.joins('INNER JOIN search_modules ON search_indices.searchable_type = search_modules.name')
      .where('search_modules.name = ?', name)
  end
end
