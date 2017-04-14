module Concerns
  module ContentType
    extend ActiveSupport::Concern

    included do
      after_save -> { column.touch if column.present? }
    end

    def column
      ContentColumn.find_by(content: self)
    end

    def parent
      column.row.rowable
    end

    def content_type_is?(value)
      value.to_sym == content_type.to_sym
    end
  end
end
