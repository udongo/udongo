class Tag < ApplicationRecord
  include Concerns::Locale

  has_many :tagged_items, dependent: :destroy

  validates :locale, :name, :seo_slug, presence: true
  validates :seo_slug, uniqueness: { case_sensitive: false, scope: :locale }

  alias_attribute :slug, :seo_slug
end
