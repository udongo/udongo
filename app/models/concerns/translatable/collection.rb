module Concerns
  module Translatable
    class Collection
      def initialize(parent, config, locale)
        @parent = parent
        @config = config
        @locale = locale
        @translations = {}
      end

      def method_missing(method_sym, *arguments, &block)
        ascii_name = method_sym.to_s.gsub('=', '').to_sym

        if @config.fields.include?(ascii_name)
          if method_sym.to_s.include?('=')
            write(ascii_name, arguments.first)
          else
            read(method_sym)
          end
        else
          super
        end
      end

      def read(field)
        init_field(field.to_sym)
        @translations[field.to_sym].value
      end

      def write(field, value)
        init_field(field.to_sym)
        @translations[field.to_sym].value = value
      end

      def save
        @translations.map { |field,object| object.save }

        @parent.update_attribute(
          :locales,
          @parent.translations.where.not(value: nil).pluck(:locale).uniq.sort
        )
      end

      private

      def init_field(field)
        unless @translations[field.to_sym]
          raise "The field '#{field.to_s}' is not allowed." unless @config.allowed?(field)

          @translations[field] = Translation.find_or_create_by!(
            translatable_type: @parent.class.name,
            translatable_id: @parent.id,
            locale: @locale,
            name: field
          )
        end
      end
    end
  end
end
