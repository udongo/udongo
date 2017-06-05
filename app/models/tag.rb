class Tag < ApplicationRecord
  include Concerns::Locale

  has_many :tagged_items, dependent: :destroy

  validates :locale, :name, :slug, presence: true
  validates :slug, uniqueness: { case_sensitive: false, scope: :locale }
end
