module Concerns
  module Searchable
    extend ActiveSupport::Concern

    included do
      has_many :search_indices, as: :searchable, dependent: :destroy

      # The after_save block creates or saves indices for every indicated
      # searchable field. Takes both translations and flexible content into
      # account.
      #
      # Translation support was relatively painless, but FlexibleContent
      # required more thought. See #save_flexible_content_indices!
      after_save do
        self.class.searchable_fields_list.each do |key|
          if key == :flexible_content
            save_flexible_content_search_indices! && next
          end

          if respond_to?(:translatable?) && self.class.translatable_fields_list.include?(key)
            save_translatable_search_index!(key)
          else
            save_search_index!(key)
          end
        end
      end

      # I save all ContentText#content values as indices linked to the parent
      # object. The Udongo::Search::Base#indices method already groups by
      # searchable resource, so there are never any duplicates.
      # Only additional matches for the searchable because it takes
      # ContentText#content sources into account.
      #
      # ContentColumn and ContentText have after_{save,destroy} callbacks
      # to help facilitate searchable management. Note that said code was
      # initially present in this class, and it was such a mess that it became
      # unpractical to maintain.
      def save_flexible_content_search_indices!
        content_rows.each do |row|
          row.columns.each do |column|
            next unless column.content.is_a?(ContentText)
            key = "flexible_content:#{column.content_id}"
            index = search_indices.find_or_create_by!(locale: row.locale, key: key)
            index.value = column.content.content
            index.save!
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

      def searchable?
        true
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
