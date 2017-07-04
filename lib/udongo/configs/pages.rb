module Udongo
  module Configs
    class Pages
      include Virtus.model

      attribute :images, Axiom::Types::Boolean, default: false

      def images?
        images === true
      end
    end
  end
end
