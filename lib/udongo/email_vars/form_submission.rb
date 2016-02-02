module Udongo
  module EmailVars
    class FormSubmission
      attr_reader :submission

      def initialize(form_submission)
        @submission = form_submission
      end

      def to_hash(prefix: 'submission')
        submission.data.inject({}) do |hash, current|
          hash["#{prefix}.#{current.name}".to_sym] = current.value
          hash
        end
      end
    end
  end
end
