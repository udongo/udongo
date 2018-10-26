module Udongo::Redirects
  class UriSanitizer
    def initialize(uri)
      @uri = uri
    end

    def sanitize!
      result = strip_whitespace(@uri)
      result = remove_leading_slashes(result)
      result = remove_trailing_slashes(result)
      result
    end

    def strip_whitespace(value)
      value.strip
    end

    def remove_leading_slashes(value)
      value.gsub(/^(?!\/)/, '/')
    end

    def remove_trailing_slashes(value)
      value.chomp('/').gsub('/?', '?').gsub('/#', '#')
    end
  end
end
