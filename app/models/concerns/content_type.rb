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
  end
end
