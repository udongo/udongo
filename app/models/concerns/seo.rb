module Concerns
  module Seo
    extend ActiveSupport::Concern

    included do
      has_many :meta, as: :sluggable, dependent: :destroy
    end

    module ClassMethods
      def find_by_slug(slug, locale: I18n.locale)
        joins(:meta).where('meta.locale' => locale, 'meta.slug' => slug).first
      end
    end

    def seo(locale = I18n.locale)
      meta.where(locale: locale).first || meta.new(locale: locale)
    end
  end
end
