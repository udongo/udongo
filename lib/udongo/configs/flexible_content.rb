module Udongo
  module Configs
    class FlexibleContent
      include Virtus.model

      BREAKPOINTS = %w(xs sm md lg xl)

      attribute :types, Array, default: %w(text image)
      attribute :allowed_breakpoints, Array, default: BREAKPOINTS

      def breakpoints
        BREAKPOINTS
      end

      def allowed_breakpoint?(value)
        allowed_breakpoints.include?(value.to_s)
      end
    end
  end
end
