module Udongo
  module Forms
    class SubmissionFilter
      def initialize(params = {})
        @data = FormSubmissionData.all
        @params = params
      end

      def result
        # TODO: Perform filters/sorting
        FormSubmission.where(id: @data.pluck(:submission_id).uniq)
      end

      def self.search(*args)
        new(*args)
      end
    end
  end
end
