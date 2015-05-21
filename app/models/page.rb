class Page < ActiveRecord::Base
  include Concerns::Translatable
  include Concerns::Taggable
  include Concerns::Loggable
  include Concerns::Parentable
  include Concerns::Visible
  include Concerns::Seo
  include Concerns::Deletable
  include Concerns::Sortable
  include Concerns::Draggable

  sortable scope: [:parent_id, :trashed]

  translatable_fields :title, :subtitle, :content

  has_many :navigation_items

  validates :description, presence: true
  validates :identifier, uniqueness: { case_sensitive: false }, allow_blank: true
end
