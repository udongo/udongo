module Udongo
  class Config
    attr_accessor :default_locale, :locales, :prefix_routes_with_locale, :host,
                  :time_zone

    def initialize
      @default_locale = :nl
      @locales = %w(nl en fr de)
      @prefix_routes_with_locale = true
      @host = 'udongo.dev'
      @time_zone = 'Brussels'
    end
  end
end
