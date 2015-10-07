class NavigationItem < ActiveRecord::Base
  include Concerns::Sortable

  include Concerns::Translatable
  translatable_fields :title, :path

  belongs_to :navigation
  belongs_to :page

  validates :navigation, presence: true
end
