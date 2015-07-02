module Concerns
  module ContentType
    extend ActiveSupport::Concern

    def column
      ::ContentColumn.where(content_type: self.class.name, content_id: id).take
    end
  end
end
