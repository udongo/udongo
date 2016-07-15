module Udongo
  class Form
    include ActiveModel::Model
    include Virtus.model

    def initialize(params = {})
      attributes.keys.each { |k| send("#{k}=", params[k]) } if params.any?
    end

    def persisted?
      false
    end

    def save(params)
      attributes.keys.each { |k| send("#{k}=", params[k]) }

      if valid?
        save_object
        true
      else
        false
      end
    end

    # This method only exists so the related factory tests pass
    def save!
      valid?
    end

    private

    # Written in the subclass
    def save_object
    end
  end
end
