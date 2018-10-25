require 'curb'

module Udongo::Redirects
  class Test
    def initialize(redirect)
      @redirect = redirect
    end

    # follow_location means curl can find out if the eventual endpoint has
    # a 200, a 404, a 500, etc,... It's a bit slower, but it's more reliable.
    # (You don't want to have an OK for a 301 when that 301 leads to a 404)
    def perform!(base_url: Udongo.config.base.host, follow_location: true)
      response = Curl::Easy.perform(base_url + @redirect.source_uri) do |curl|
        curl.head = true
        curl.follow_location = follow_location
      end

      Response.new(response)
    end
  end
end
