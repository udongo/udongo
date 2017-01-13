module Concerns
  module Searchable
    extend ActiveSupport::Concern

    included do
      has_many :search_indices, as: :searchable, dependent: :destroy

      # TODO: callbacks.
      # Create indices for every indicated searchable field.
      # Update them when their searchable values change.
      # Make sure to take translations into account.
      after_create do
        self.class.searchable_fields_list.each do |key|
          if translatable?
            next unless self.class.translatable_fields_list.include?(key)

            Udongo.config.i18n.app.locales.each do |locale|
              value = translation(locale.to_sym).send(key)
              next if value.blank?
              search_indices.create!(locale: locale, key: key, value: value)
            end
          else
            search_indices.create!(
              locale: Udongo.config.i18n.app.default_locale,
              key: key,
              value: send(key)
            )
          end
        end
      end

      # TODO:
      after_save do
      end
    end

    module ClassMethods
      def searchable_field(key)
        unless searchable_fields_list.include?(key.to_sym)
          searchable_fields_list << key.to_sym
        end
      end

      def searchable_fields(*args)
        args.each { |key| searchable_field(key) }
      end

      def searchable_fields_list
        @searchable_fields_list ||= []
      end
    end
  end
end
