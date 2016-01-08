# To use this module you need to add a text column to your model. This will be
# used to determine in which locales the translations exist.
module Concerns
  module Translatable
    extend ActiveSupport::Concern

    included do
      serialize :locales, Array
      has_many :translations, as: :translatable, dependent: :destroy
      scope :within_locale, ->(locale) { where('locales LIKE ?', "%#{locale}%")}
    end

    def translation(locale = I18n.locale)
      @translation_collections = {} unless @translation_collections
      @translation_collections[locale.to_sym] ||= Concerns::Translatable::Collection.new(
        self, self.class.translation_config, locale
      )
    end

    def translatable?
      true
    end

    module ClassMethods
      def translatable_field(name)
        delegate name, to: :translation
        translation_config.add(name)
      end

      def translatable_fields(*args)
        args.each { |name| translatable_field(name) }
      end

      def translation_config
        @translation_config ||= Concerns::Translatable::Config.new
      end
    end
  end
end
