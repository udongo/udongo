module Concerns
  module Seo
    extend ActiveSupport::Concern

    included do
      has_many :meta, as: :sluggable, dependent: :destroy
    end

    module ClassMethods
      def find_by_slug(slug, locale: I18n.locale)
        joins(:meta).where('meta.locale' => locale, 'meta.slug' => slug, 'meta.sluggable_type' => self.name).first
      end
    end

    # TODO refactor me
    def seo(locale = I18n.locale)
      @seo_collections = {} unless @seo_collections

      if @seo_collections[locale.to_sym]

      elsif meta.find_by(locale: locale)
        @seo_collections[locale.to_sym] = meta.find_by(locale: locale)

      else
        @seo_collections[locale.to_sym] = meta.new(locale: locale)
      end

      @seo_collections[locale.to_sym]
    end
  end
end
