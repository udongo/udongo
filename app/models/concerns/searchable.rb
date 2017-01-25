module Concerns
  module Searchable
    extend ActiveSupport::Concern

    included do
      has_many :search_indices, as: :searchable, dependent: :destroy

      # TODO: What on earth am I going to do with FlexibleContent?
      #
      # A possible solution could have been to make ContentText searchable,
      # but because that model is not polymorphic, this is not possible.
      #
      # Another solution in the realms of the feasible, with Page as example:
      # In theory, if I could save the ContentText#content value as an index
      # linked to the parent Page object, there would be no problem. I would
      # let ContentText include Concerns::Searchable, and in this class
      # build in an exception to bubble up to the page instance. This is
      # possible through:
      # ContentColumn.find_by(content: ContentText.last).row.rowable
      #
      # The Udongo::Search::Base#indices method already groups by searchable
      # so in this case there wouldn't be duplicates, only additional matches
      # for the searchable because it takes ContentText#content into account.

      # Creates and saves indices for every indicated searchable field.
      # Takes translations into account.
      after_save do
        self.class.searchable_fields_list.each do |key|
          if translatable?
            next unless self.class.translatable_fields_list.include?(key)
            save_translatable_search_index!(key)
          else
            save_search_index!(key)
          end
        end
      end

      def save_search_index!(key)
        value = send(key)
        return if value.blank?
        index = search_indices.find_or_create_by!(locale: Udongo.config.i18n.app.default_locale, key: key)
        index.value = value
        index.save!
      end

      def save_translatable_search_index!(key)
        Udongo.config.i18n.app.locales.each do |locale|
          value = translation(locale.to_sym).send(key)
          next if value.blank?
          index = search_indices.find_or_create_by!(locale: locale, key: key)
          index.value = value
          index.save!
        end
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
