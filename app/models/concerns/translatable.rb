# To use this module you need to add a text column to your model. This will be
# used to determine in which locales the translations exist.
module Concerns
  module Translatable
    extend ActiveSupport::Concern
    include Concerns::Storable

    included do
      serialize :locales, Array

      after_save do
        locales = Store.where(
          storable_type: self.class.to_s,
          storable_id: self.id,
          name: self.class.translatable_fields_list
        ).where('value IS NOT NULL AND value != "---''\n" AND value != ""').
          pluck(:collection).uniq

        update_column :locales, locales
      end

      scope :with_locale, ->(locale) { where('locales LIKE ?', "%#{locale}%")}
    end

    def translatable?
      true
    end

    def translation(locale = I18n.locale)
      store(locale)
    end

    module ClassMethods
      def translatable_field(name, type = String, default = nil)
        delegate name, "#{name}=", to: :translation
        self.store_config.add name, type, default

        unless translatable_fields_list.include?(name.to_sym)
          translatable_fields_list << name.to_sym
        end
      end

      def translatable_fields(*args)
        args.each { |name| translatable_field(name) }
      end

      def translatable_fields_list
        @translatable_fields_list ||= []
      end
    end
  end
end
