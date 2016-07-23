module Udongo
  module Configs
    class FlexibleContent
      include Virtus.model

      attribute :types, Array, default: %w(text image)
    end
  end
end
