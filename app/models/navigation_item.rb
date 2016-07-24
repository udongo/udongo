class NavigationItem < ApplicationRecord
  include Concerns::Sortable
  sortable scope: :navigation_id

  include Concerns::Translatable
  translatable_fields :label, :path

  belongs_to :navigation
  belongs_to :page

  validates :navigation, presence: true
end
