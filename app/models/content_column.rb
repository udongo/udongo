class ContentColumn < ApplicationRecord
  include Concerns::Sortable
  sortable(scope: :row_id)

  # Removing a column from a searchable object should remove the linked
  # SearchIndex instance.
  after_destroy do
    next unless linked_to_searchable_parent?
    parent.search_indices.where(key: "flexible_content:#{content_id}").destroy_all
  end

  belongs_to :row, class_name: 'ContentRow', touch: true
  belongs_to :content, polymorphic: true, dependent: :destroy

  validates :row, presence: true
  validates :width_xs, :width_sm, :width_md, :width_lg, :width_xl,
            presence: true,
            numericality: { greater_than: 0, less_than_or_equal_to: 12,  only_integer: true }

  default_scope -> { order(:position) }

  def linked_to_searchable_parent?
    parent.present? && parent.searchable?
  end

  def parent
    row.rowable
  end
end
