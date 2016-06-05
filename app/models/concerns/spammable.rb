# If you want to use this module, you need to add a boolean field
# 'marked_as_spam' to the model.
module Concerns
  module Spammable
    extend ActiveSupport::Concern

    included do
      scope :spam, ->{ where(marked_as_spam: true) }
      scope :not_spam, -> { where('marked_as_spam = 0 OR marked_as_spam IS NULL') }

      after_initialize :spam_defaults
    end

    def mark_as_spam!
      update_attribute :marked_as_spam, true
    end

    def unmark_as_spam!
      update_attribute :marked_as_spam, false
    end

    private

    def spam_defaults
      if self.new_record?
        self.marked_as_spam = false if marked_as_spam.nil?
      end
    end
  end
end
