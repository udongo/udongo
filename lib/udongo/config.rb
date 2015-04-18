module Udongo
  class Config
    attr_accessor :default_locale, :locales, :host, :time_zone

    def initialize
      @default_locale = :nl
      @locales = %w(nl en fr de)
      @host = 'udongo.dev'
      @time_zone = 'Brussels'
    end
  end
end
