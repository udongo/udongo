module Udongo
  module Configs
    class FlexibleContent
      include Virtus.model

      attribute :types, Array, default: %w(text image)
      attribute :allowed_column_widths, Array, default: %w(xs sm md lg xl)

      def column_width_allowed?(dimension)
        allowed_column_widths.include?(dimension.to_s)
      end
    end
  end
end
