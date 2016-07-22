module Udongo
  module Forms
    class SubmissionDatagrid
      include Udongo::Forms::Config
      include ActionView::Helpers::TagHelper

      def initialize(form)
        @form = form
      end

      def column_values(submission)
        map_fields { |field| content_tag(:td, submission.data_object.send(field)) }
      end

      def column_headers(filter)
        map_fields { |field| content_tag(:th, I18n.t("b.#{field}")) }
      end

      def fields
        return [] if config.nil?
        config.datagrid_fields
      end

      def map_fields(&block)
        fields.map { |field| yield(field) }.join("\n").html_safe
      end
    end
  end
end
