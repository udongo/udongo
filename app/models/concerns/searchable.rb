module Concerns
  module Searchable
    extend ActiveSupport::Concern

    included do
      has_many :search_indices, as: :searchable, dependent: :destroy
    end
  end
end
