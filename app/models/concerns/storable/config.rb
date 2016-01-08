module Concerns
  module Storable
    class Config
      attr_reader :fields

      def initialize
        @fields = {}
      end

      def add(field, klass, default = nil)
        @fields[field.to_sym] = {
          klass: klass.to_sym,
          default: default
        }
      end

      def allowed?(field)
        @fields.keys.include?(field.to_sym)
      end
    end
  end
end
