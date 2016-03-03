module Concerns
  module Loggable
    extend ActiveSupport::Concern

    included do
      has_many :logs, as: :loggable, dependent: :destroy
    end

    def log(message, category: nil, data: nil)
      logs.create!(content: message, category: category, data: data)
    end
  end
end
