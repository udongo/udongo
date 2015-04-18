module Concerns
  module Translatable
    extend ActiveSupport::Concern

    def translation(locale = I18n.locale)
      @collections = {} unless @collections
      @collections[locale.to_sym] ||= Collection.new(self, self.class.translation_config, locale)
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
