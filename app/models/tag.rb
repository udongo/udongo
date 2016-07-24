class Tag < ApplicationRecord
  include Concerns::Locale

  validates :locale, :name, :slug, presence: true
  validates :slug, uniqueness: { case_sensitive: false, scope: :locale }
end
