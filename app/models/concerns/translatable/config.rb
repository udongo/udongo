module Concerns
  module Translatable
    class Config
      attr_reader :fields

      def initialize
        @fields = []
      end

      def add(field)
        @fields << field.to_sym unless @fields.include?(field.to_sym)
      end

      def allowed?(field)
        @fields.include?(field.to_sym)
      end
    end
  end
end
