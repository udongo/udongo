class Image < ApplicationRecord
  include Concerns::Visible

  include Concerns::Sortable
  sortable scope: [:asset_id]

  belongs_to :asset
  belongs_to :imageable, polymorphic: true

  validates :asset, presence: true
end
