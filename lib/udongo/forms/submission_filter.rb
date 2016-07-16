module Udongo
  module Forms
    class SubmissionFilter
      attr_reader :form, :params

      def initialize(form, params = {})
        @form = form
        @params = params || {}
      end

      # TODO: Refactor duplicate in lib/udongo/forms/submission_datagrid.rb
      def config
        @config ||= Udongo.config.form_submissions[form.identifier.to_sym]
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
