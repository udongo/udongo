module Concerns
  module Loggable
    extend ActiveSupport::Concern

    included do
      has_many :logs, as: :loggable, dependent: :destroy
    end

    def log(message, category = nil)
      logs.create!(content: message, category: category)
    end
  end
end
