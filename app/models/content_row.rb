class ContentRow < ActiveRecord::Base
  include Concerns::Sortable

  belongs_to :rowable, polymorphic: true
  has_many :columns, class_name: 'ContentColumn', foreign_key: :row_id, dependent: :destroy

  validates :locale, :rowable_type, :rowable_id, presence: true

  sortable scope: [:locale, :rowable_type, :rowable_id]
end
