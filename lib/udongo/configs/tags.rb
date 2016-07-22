module Udongo
  module Configs
    class Tags
      include Virtus.model

      attribute :allow_new, Axiom::Types::Boolean, default: true
    end
  end
end
