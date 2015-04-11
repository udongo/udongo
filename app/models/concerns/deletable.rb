# If you want to use this concern, you need to add a boolean field 'deletable' to
# the model.
module Concerns
  module Deletable
    extend ActiveSupport::Concern

    included do
      after_initialize do
        self.deletable = true if self.new_record? && deletable.nil?
      end
    end
  end
end
