class Tag < ActiveRecord::Base
  validates :locale, :name, :slug, presence: true
  validates :slug, uniqueness: { case_sensitive: false, scope: [:locale] }
end

