module Concerns
  module Imageable
    extend ActiveSupport::Concern

    included do
      has_many :images, as: :imageable
    end

    def imageable?
      true
    end
  end
end
