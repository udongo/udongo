module Udongo::Redirects
  class Response
    def initialize(response)
      @response = response
    end

    def endpoint_matches?(destination)
      sanitize_destination(destination) == headers['Location']
    end

    # Apparently Curb does not provide parsed headers... A bit sad.
    # TODO: Handle multiple location headers so #endpoint_matches? can succeed.
    # For now, the last location header is returned as a value.
    def headers
      list = @response.header_str.split(/[\r\n]+/).map(&:strip)
      Hash[list.flat_map{ |s| s.scan(/^(\S+): (.+)/) }]
    end

    def raw
      @response
    end

    def sanitize_destination(destination)
      destination.to_s
                 .gsub('/#', '#')
                 .gsub('/?', '?')
                 .chomp('/')
    end

    def success?
      ['200 OK', '301 Moved Permanently'].include?(@response.status)
    end
  end
end
