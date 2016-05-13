class ContentColumn < ActiveRecord::Base
  include Concerns::Sortable
  sortable(scope: :row_id)

  belongs_to :row, class_name: 'ContentRow', touch: true
  belongs_to :content, polymorphic: true, dependent: :destroy

  validates :row, presence: true
  validates :width_xs, :width_sm, :width_md, :width_lg, :width_xl,
            presence: true,
            numericality: { greater_than: 0, less_than_or_equal_to: 12,  only_integer: true }

  default_scope -> { order(:position) }
end
