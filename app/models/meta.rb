class Meta < ApplicationRecord
  include Concerns::Locale

  belongs_to :sluggable, polymorphic: true, touch: true

  validates :locale, presence: true

  %w(title keywords description custom slug).each do |field|
    alias_attribute "seo_#{field}".to_sym, field
  end
end
