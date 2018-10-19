module Udongo::Redirects
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
