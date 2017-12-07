class Meta < ApplicationRecord
  include Concerns::Locale

  belongs_to :sluggable, polymorphic: true, touch: true

  validates :locale, presence: true

  SEO_ATTRIBUTES = %w(title keywords description custom_head slug)

  SEO_ATTRIBUTES.each do |field|
    alias_attribute "seo_#{field}".to_sym, field
  end

  alias_attribute :seo_custom, :seo_custom_head
end
