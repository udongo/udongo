module Concerns
  module Storable
    class Config
      KLASSES = %w(array boolean date date_time float integer string)
      attr_reader :fields

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
        KLASSES.include?(value.to_s)
      end
    end
  end
end
