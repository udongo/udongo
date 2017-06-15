module Udongo
  module Configs
    module I18ns
      class Cms
        include Virtus.model

        attribute :default_interface_locale, String, default: 'nl'
        attribute :interface_locales, Array, default: %w(nl en)
      end
    end
  end
end
