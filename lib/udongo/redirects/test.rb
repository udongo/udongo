require 'curb'

module Udongo::Redirects
  class Test
    def initialize(redirect)
      @redirect = redirect
    end

    def perform!(base_url: Udongo.config.base.host)
      Curl::Easy.perform(base_url + @redirect.source_uri) do |curl|
        curl.head = true
        curl.follow_location = true
      end
    end
  end
end
