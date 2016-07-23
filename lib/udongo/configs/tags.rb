module Udongo
  module Configs
    class Tags
      include Virtus.model

      attribute :allow_new, Axiom::Types::Boolean, default: true

      def allow_new?
        allow_new === true
      end
    end
  end
end
