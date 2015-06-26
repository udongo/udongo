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

  # TODO move me to concern
  has_many :content_rows, as: :rowable, dependent: :destroy

  sortable scope: [:parent_id]

  translatable_fields :title, :subtitle

  validates :description, presence: true
  validates :identifier, uniqueness: { case_sensitive: false }, allow_blank: true
end
