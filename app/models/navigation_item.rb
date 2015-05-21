class NavigationItem < ActiveRecord::Base
  include Concerns::Sortable

  sortable scope: :list_id

  belongs_to :list, class: NavigationList, foreign_key: :list_id
  belongs_to :page

  validates :page, :list, presence: true
end
