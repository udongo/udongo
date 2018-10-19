module Udongo::Redirects
  class Response
    def initialize(response)
      @response = response
    end

    def not_found?
      @response.status == '404 Not Found'
    end

    def ok?
      @response.status == '200 OK'
    end

    def redirect_works?(destination)
      (sanitize_destination(destination) == @response.last_effective_url) && ok?
    end

    def sanitize_destination(destination)
      destination.to_s
                 .split('#').first
                 .gsub('/?', '?')
                 .chomp('/')
    end
  end
end
