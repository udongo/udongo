module Concerns
  module Storable
    class Collection
      def initialize(parent, config)
        @parent = parent
        @config = config
        @stores = {}
      end

      def method_missing(method_sym, *arguments, &block)
        ascii_name = method_sym.to_s.gsub('=', '').to_sym

        if @config.fields.keys.include?(ascii_name)
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
        @stores[field.to_sym].value
      end

      def write(field, value)
        init_field(field.to_sym)
        @stores[field.to_sym].value = value
      end

      def save
        @stores.map { |field,object| object.save }
      end

      private

      def init_field(field)
        unless @stores[field.to_sym]
          raise "The field '#{field.to_s}' is not allowed." unless @config.allowed?(field)

          @stores[field] = ::Store.find_or_create_by!(
            storable_type: @parent.class.name,
            storable_id: @parent.id,
            klass: @config.fields[field.to_sym][:klass],
            name: field
          )
        end
      end
    end
  end
end
