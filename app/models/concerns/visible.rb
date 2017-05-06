# If you want to use this concern, you need to add a boolean field 'visible' to
# the model.
module Concerns
  module Visible
    extend ActiveSupport::Concern

    included do
      scope :visible, -> { where(visible: true) }
      scope :hidden, -> { where('visible = 0 OR visible IS NULL') }
    end

    def hidden?
      !visible?
    end

    def hide!
      update_attribute :visible, false
    end

    def show!
      update_attribute :visible, true
    end
  end
end
