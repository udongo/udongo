class Tag < ApplicationRecord
  include Concerns::Locale
  include Concerns::Seo

  include Concerns::Translatable
  translatable_fields :summary

  has_many :tagged_items, dependent: :destroy

  validates :locale, :name, :slug, presence: true
  validates :slug, uniqueness: { case_sensitive: false, scope: :locale }
end
