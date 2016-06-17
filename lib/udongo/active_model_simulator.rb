module Udongo
  class ActiveModelSimulator
    include ActiveModel::Model

    def initialize(attributes = {})
      attributes ||= {}
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    def persisted?
      false
    end

    # This method exists so the related factory tests pass
    def save!
      valid?
    end
  end
end
