module Udongo
  module Configs
    class I18n
      include Virtus.model

      attribute :default_locale, String, default: 'nl'
      attribute :locales, Array, default: %w(nl en fr de)
    end
  end
end
