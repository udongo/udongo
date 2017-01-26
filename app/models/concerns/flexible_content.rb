module Concerns
  module FlexibleContent
    extend ActiveSupport::Concern

    included do
      has_many :content_rows, as: :rowable, dependent: :destroy
    end

    def flexible_content?
      true
    end
  end
end
