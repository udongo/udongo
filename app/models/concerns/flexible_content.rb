module Concerns
  module FlexibleContent
    extend ActiveSupport::Concern

    included do
      has_many :content_rows, as: :rowable, dependent: :destroy
    end
  end
end
