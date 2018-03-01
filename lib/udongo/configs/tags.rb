module Udongo
  module Configs
    class Tags
      include Virtus.model

      attribute :allow_new, Axiom::Types::Boolean, default: true
      attribute :editor_for_summary, Axiom::Types::Boolean, default: false

      def allow_new?
        allow_new === true
      end

      def editor_for_summary?
        editor_for_summary === true
      end
    end
  end
end
