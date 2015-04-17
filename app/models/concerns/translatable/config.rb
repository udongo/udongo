module Concerns
  module Translatable
    # A hash is used to hold all the fields. This looks something like this:
    # {
    #   title: {
    #     type: :string
    #   },
    #   content: {
    #     type: :text
    #   }
    # }
    class Config
      def initialize
        @fields = {}
      end

      def add(field, type: :string)
        @fields[field.to_sym] = { type: type.to_sym }
      end

      def allowed?(field)
        @fields.key?(field.to_sym)
      end

      def fields
        @fields.keys
      end

      def type(field)
        raise "No such field (#{field})" unless allowed?(field)
        @fields[field.to_sym][:type]
      end
    end
  end
end
