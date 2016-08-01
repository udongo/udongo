module Udongo
  module Forms
    class SubmissionFilter
      attr_reader :params

      def initialize(form, params = {})
        @form = form
        @params = params || {}
      end

      def condition(key, value)
        @form.data.where(name: key).where('value REGEXP ?', value)
      end

      def fields
        Udongo.config.forms.send(@form.identifier).filter_fields
      end

      def result
        data = @form.data

        params.inject([]) do |conditions,param|
          key, value = param
          next if value.blank?

          if conditions.any?
            data = data.or(condition(key, value))
          else
            data = condition(key, value)
            conditions << data
          end
        end

        @form.submissions.where(id: data.pluck(:submission_id).uniq)
      end

      def self.search(*args)
        new(*args)
      end
    end
  end
end
