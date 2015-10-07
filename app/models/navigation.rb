class Navigation < ActiveRecord::Base
  has_many :items, class_name: 'NavigationItem', dependent: :destroy

  validates :description, presence: true
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
