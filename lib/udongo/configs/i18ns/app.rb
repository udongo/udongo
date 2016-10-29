module Udongo
  module Configs
    module I18ns
      class App
        include Virtus.model

        attribute :default_locale, String, default: 'nl'
        attribute :locales, Array, default: %w(nl)
      end
    end
  end
end
