class ContentColumn < ActiveRecord::Base
  include Concerns::Sortable
  sortable(scope: :row_id)

  belongs_to :row, class_name: 'ContentRow', touch: true
  belongs_to :content, polymorphic: true, dependent: :destroy

  validates :row, :width, presence: true
  validates :width,
            presence: true,
            numericality: { greater_than: 0, less_than_or_equal_to: 12,  only_integer: true }

  default_scope -> { order(:position) }
end
