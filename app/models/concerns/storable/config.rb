module Concerns
  module Storable
    class Config
      attr_reader :fields

      KLASSES = {
        array: [Array],
        boolean: [TrueClass, FalseClass],
        date: [Date],
        date_time: [DateTime],
        float: [Float],
        integer: [Fixnum],
        string: [String]
      }

      def initialize
        @fields = {}
      end

      def add(field, klass, default = nil)
        raise "#{klass} is not a valid storable config klass" unless valid_klass?(klass)

        @fields[field.to_sym] = {
          klass: klass.to_sym,
          default: default
        }
      end

      def allowed?(field)
        @fields.keys.include?(field.to_sym)
      end

      private

      def valid_klass?(value)
        KLASSES.keys.include?(value.to_sym)
      end
    end
  end
end
