class ContentText < ApplicationRecord
  include Concerns::ContentType

  # This triggers the searchable instance's after_save callback, which
  # in turn updates all search indices.
  after_save { parent.save! if linked_to_searchable_parent? }

  def column
    ContentColumn.find_by(content: self)
  end

  def content_type
    :text
  end

  def linked_to_searchable_parent?
    column.present? && parent.present? && parent.searchable?
  end

  def parent
    column.row.rowable
  end
end
