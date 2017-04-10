module Udongo
  module Forms
    class SubmissionDatagrid
      include ActionView::Helpers::TagHelper

      def initialize(form)
        @form = form
      end

      def column_values(submission)
        map_fields { |field| content_tag(:td, submission.data_object.send(field)) }
      end

      def column_headers
        map_fields { |field| content_tag(:th, I18n.t("b.#{field}")) }
      end

      def fields
        Udongo.config.forms.send(@form.identifier).datagrid_fields
      end

      def map_fields(&block)
        fields.map { |field| yield(field) }.join("\n").html_safe
      end
    end
  end
end
