module Udongo
  module Configs
    class Routes
      include Virtus.model

      attribute :prefix_with_locale, Axiom::Types::Boolean, default: true

      def prefix_with_locale?
        prefix_with_locale === true
      end
    end
  end
end
