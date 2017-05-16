module Udongo
  module Configs
    class FlexibleContent
      include Virtus.model

      BREAKPOINTS = %w(xs sm md lg xl)
      DEFAULT_BREAKPOINT = 'md'

      attribute :types, Array, default: %w(text picture video image)
      attribute :picture_caption_editor, Axiom::Types::Boolean, default: false

      def picture_caption_editor?
        picture_caption_editor
      end
    end
  end
end
