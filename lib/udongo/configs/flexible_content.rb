module Udongo
  module Configs
    class FlexibleContent
      include Virtus.model

      BREAKPOINTS = %w(xs sm md lg xl)
      DEFAULT_BREAKPOINT = 'md'

      attribute :types, Array, default: %w(text picture image)

      # TODO remove this
      attribute :allowed_breakpoints, Array, default: BREAKPOINTS

      # TODO remove this
      def allowed_breakpoint?(value)
        allowed_breakpoints.include?(value.to_s)
      end
    end
  end
end
