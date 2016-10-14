module Concerns
  module Addressable
    class Config
      attr_reader :fields, :default

      def initialize
        @fields = []
        @default = nil
      end

      def update(categories, default: nil)
        unless categories.respond_to?(:each) && categories.any?
          raise 'Please provide an array with address categories'
        end

        @fields = categories.map(&:to_sym).uniq
        @default = @fields.first

        if default
          unless @fields.include?(default.to_sym)
            raise "You can't make '#{default.to_s}' the default address category because it's not in the list of categories"
          end

          @default = default.to_sym
        end
      end

      def allowed?(field)
        @fields.include?(field.to_sym)
      end
    end
  end
end
