class Navigation < ActiveRecord::Base
  validates :description, presence: true
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
