module Udongo
  module Forms
    class SubmissionFilter
      include Udongo::Forms::Config
      attr_reader :params

      def initialize(form, params = {})
        @form = form
        @params = params || {}
      end

      def fields
        return [] if config.blank?
        config[:filter]
      end

      def result
        data = FormSubmissionData.all
        params.each do |key,value|
          next if value.blank?
          data = data.where(name: key).where('value REGEXP ?', value)
        end
        FormSubmission.where(id: data.pluck(:submission_id).uniq)
      end

      def self.search(*args)
        new(*args)
      end
    end
  end
end
