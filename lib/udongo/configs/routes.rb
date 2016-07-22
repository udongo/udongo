module Udongo
  module Configs
    class Routes
      include Virtus.model

      attribute :prefix_with_locale, Axiom::Types::Boolean, default: true
    end
  end
end
