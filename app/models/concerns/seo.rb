module Concerns
  module Seo
    extend ActiveSupport::Concern

    included do
      serialize :seo_locales, Array
      has_many :meta, as: :sluggable, dependent: :destroy

      after_save do
        locales = Meta.where(
          sluggable_type: self.class.to_s,
          sluggable_id: self.id
        ).where('slug IS NOT NULL OR slug != ""').pluck(:locale).uniq

        update_column :seo_locales, locales

        # This is a bit of a long story. For some reason when you save the
        # parent object, the SEO info is -not always- saved. At the moment I'm
        # unable to reproduce it consistently. Therefor I've added some extra
        # code to manually loop the seo collections and save them.
        @seo_collections.keys.each { |l| seo(l).save } if @seo_collections
      end

      scope :with_seo, ->(locale) { where('seo_locales LIKE ?', "%#{locale}%")}
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
