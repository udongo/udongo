module Udongo
  module Configs
    class FlexibleContent
      include Virtus.model

      attribute :types, Array, default: %w(text image)
      attribute :allowed_column_dimensions, Array, default: %w(xs sm md lg xl)

      def column_dimension_allowed?(value)
        allowed_column_dimensions.include?(value.to_s)
      end
    end
  end
end
