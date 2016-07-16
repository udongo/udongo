module Udongo
  module Forms
    class SubmissionDatagrid
      include ActionView::Helpers::TagHelper

      attr_reader :form

      def initialize(form)
        @form = form
      end

      def column_values(submission)
        map_fields { |field| content_tag(:td, submission.data_object.send(field)) }
      end

      # TODO: Through filter we can perhaps prepare sort links here?
      def column_headers(filter)
        map_fields { |field| content_tag(:th, I18n.t("b.#{field}")) }
      end

      # TODO: Refactor duplicate in lib/udongo/forms/submission_filter.rb
      def config
        @config ||= Udongo.config.form_submissions[form.identifier.to_sym]
      end

      def fields
        return [] if config.blank?
        config[:datagrid_fields]
      end

      def map_fields(&block)
        fields.map { |field| yield(field) }.join("\n").html_safe
      end
    end
  end
end
