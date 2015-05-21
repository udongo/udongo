class NavigationList < ActiveRecord::Base
  has_many :items, class: NavigationItem, foreign_key: :list_id

  validates :identifier, :description, presence: true
end
