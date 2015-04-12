class Meta < ActiveRecord::Base
  belongs_to :sluggable, polymorphic: true

  validates :locale, presence: true
  validates :slug,
            presence: true,
            uniqueness: { case_sensitive: false, scope: :locale }

  %w(title keywords description custom slug).each do |field|
    alias_attribute "seo_#{field}".to_sym, field
  end
end

