require 'curb'

module Udongo::Redirects
  class Test
    def initialize(redirect)
      @redirect = redirect
    end

    def perform!(base_url: Udongo.config.base.host)
      response = Curl::Easy.perform(base_url + @redirect.source_uri) do |curl|
        curl.head = true
        curl.follow_location = true
      end

      Response.new(response)
    end
  end

  class Response
    def initialize(response)
      @response = response
    end

    def ok?
      @response.status == '200 OK'
    end

    def redirect_works?(destination)
      (destination.to_s.split('#').first == @response.last_effective_url) && ok?
    end

    def not_found?
      @response.status == '404 Not Found'
    end
  end
end
