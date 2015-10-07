class Page < ActiveRecord::Base
  include Concerns::Taggable
  include Concerns::Parentable
  include Concerns::Visible
  include Concerns::Seo
  include Concerns::Deletable
  include Concerns::Draggable
  include Concerns::FlexibleContent

  include Concerns::Sortable
  sortable scope: [:parent_id]

  include Concerns::Translatable
  translatable_fields :title, :subtitle

  include Concerns::Cacheable
  cache_by :identifier

  has_many :navigation_items, dependent: :destroy

  validates :description, presence: true
  validates :identifier, uniqueness: { case_sensitive: false }, allow_blank: true
end
