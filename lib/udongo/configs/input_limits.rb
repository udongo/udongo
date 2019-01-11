module Udongo
  module Configs
    class InputLimits
      include Virtus.model

      attribute :seo_title, Integer, default: 40
      attribute :seo_description, Integer, default: 75
    end
  end
end
