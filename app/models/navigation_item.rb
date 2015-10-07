class NavigationItem < ActiveRecord::Base
  include Concerns::Sortable
  sortable :navigation_id

  include Concerns::Translatable
  translatable_fields :label, :path

  belongs_to :navigation
  belongs_to :page

  validates :navigation, presence: true
end
