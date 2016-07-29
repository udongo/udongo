module Udongo
  class Form
    include ActiveModel::Model
    include Virtus.model

    def initialize(object)
      instance_variable_set("@#{object.class.to_s.underscore}", object)
      init_attribute_values(object)
    end

    def init_attribute_values(object)
      attributes.keys.each { |k| send("#{k}=", object.send(k)) }
    end

    def init_object_values(object)
      attributes.each { |k, v| object.send("#{k}=", v) }
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
