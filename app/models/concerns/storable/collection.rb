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
        field = field.to_sym
        init_field(field.to_sym)
        object = @stores[field]

        unless object.value.nil?
          return object.value if klasses_match(@config.fields[field][:klass], object.value)
        end

        @config.fields[field][:default]
      end

      def write(field, value)
        field = field.to_sym
        init_field(field)
        value = transform_value(@config.fields[field][:klass], value)

        @stores[field].value = value
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

      def klasses_match(klass, value)
        Concerns::Storable::Config::KLASSES[klass].include? value.class
      end

      def transform_value(klass, value)
        send("#{klass}_value", value)
      end

      def string_value(value)
        value.to_s if value.is_a?(String) || value.is_a?(Symbol)
      end

      def integer_value(value)
        value if value.is_a?(Fixnum)
      end

      def float_value(value)
        value if value.is_a?(Float)
      end

      def array_value(value)
        value if value.is_a?(Array)
      end

      def boolean_value(value)
        if value === true || value == '1' || value == 1
          true
        elsif value === false || value == '0' || value == 0
          false
        end
      end

      def date_value(value)
        return value if value.is_a?(Date)

        begin
          Date.parse(value)
        rescue
          nil
        end
      end

      def date_time_value(value)
        return value if value.is_a?(DateTime)

        begin
          DateTime.parse(value)
        rescue
          nil
        end
      end
    end
  end
end
