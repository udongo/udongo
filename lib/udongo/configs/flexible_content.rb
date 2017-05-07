module Udongo
  module Configs
    class FlexibleContent
      include Virtus.model

      BREAKPOINTS = %w(xs sm md lg xl)
      DEFAULT_BREAKPOINT = 'md'

      attribute :types, Array, default: %w(text picture video image)
    end
  end
end
