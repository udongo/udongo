module Udongo
  module Configs
    class Articles
      include Virtus.model

      attribute :allow_html_in_title, Axiom::Types::Boolean, default: false
      attribute :allow_html_in_summary, Axiom::Types::Boolean, default: false
      attribute :editor_for_summary, Axiom::Types::Boolean, default: false
      attribute :images, Axiom::Types::Boolean, default: false

      def allow_html_in_title?
        allow_html_in_title === true
      end

      def allow_html_in_summary?
        allow_html_in_summary === true
      end

      def editor_for_summary?
        editor_for_summary === true
      end

      def images?
        images === true
      end
    end
  end
end
