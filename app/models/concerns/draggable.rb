# If you want to use this concern, you need to add a boolean field 'draggable' to
# the model.
module Concerns
  module Draggable
    extend ActiveSupport::Concern

    included do
      after_initialize do
        self.draggable = true if self.new_record? && draggable.nil?
      end
    end
  end
end
