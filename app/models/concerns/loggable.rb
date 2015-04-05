module Concerns
  module Loggable
    extend ActiveSupport::Concern

    included do
      after_save :log_changes
      has_many :logs, as: :loggable, dependent: :destroy
    end

    def log(message, category = nil)
      logs.create!(content: message, category: category)
    end

    def log_changes
      if changed?
        msg = ['The following fields were changed:']
        msg << changes.map do |data|
          "[%s]\n- new: %s\n- previous: %s\n" % [data[0], data[1][1], data[1][0]]
        end

        log msg.join("\n")
      end
    end
  end
end
