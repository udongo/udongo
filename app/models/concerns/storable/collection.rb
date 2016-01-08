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

        init_field(field)
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
        if klass == :string && value.is_a?(String)
          true
        elsif klass == :array && value.is_a?(Array)
          true
        elsif klass == :boolean && (value.is_a?(TrueClass) || value.is_a?(FalseClass))
          true
        elsif klass == :date && value.is_a?(Date)
          true
        elsif klass == :date_time && value.is_a?(DateTime)
          true
        elsif klass == :float && value.is_a?(Float)
          true
        elsif klass == :integer && value.is_a?(Fixnum)
          true
        else
          false
        end
      end

      def transform_value(klass, value)
        if klass == :string
          if value.is_a? String
            return value
          elsif value.is_a? Symbol
            return value.to_s
          end

        elsif klass == :integer && value.is_a?(Fixnum)
          return value

        elsif klass == :float && value.is_a?(Float)
          return value

        elsif klass == :array && value.is_a?(Array)
          return value

        elsif klass == :boolean
          if value === true || value == '1' || value == 1
            return true
          elsif value === false || value == '0' || value == 0
            return false
          end
        end
      end
    end
  end
end
