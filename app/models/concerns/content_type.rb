module Concerns
  module ContentType
    extend ActiveSupport::Concern

    included do
      after_save -> { column.touch if column.present? }
    end

    def column
      ::ContentColumn.where(content_type: self.class.name, content_id: id).take
    end
  end
end
