module Concerns
  module Seo
    extend ActiveSupport::Concern

    included do
      has_many :meta, as: :sluggable, dependent: :destroy
    end

    module ClassMethods
      def find_by_slug(slug, locale: I18n.locale)
        joins(:meta).where(
          'meta.locale' => locale,
          'meta.slug' => slug,
          'meta.sluggable_type' => self.name
        ).first
      end

      def find_by_slug!(slug, locale: I18n.locale)
        find_by_slug(slug, locale: locale) || raise('No such record found')
      end
    end

    def seo(locale = I18n.locale)
      @seo_collections = {} unless @seo_collections
      return @seo_collections[locale.to_sym] if @seo_collections[locale.to_sym]

      existing_meta = meta.find_by(locale: locale)
      @seo_collections[locale.to_sym] = existing_meta ? existing_meta : meta.new(locale: locale)
    end
  end
end
