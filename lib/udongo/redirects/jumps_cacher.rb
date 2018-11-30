module Udongo::Redirects
  class JumpsCacher
    def initialize(redirect)
      @redirect = redirect
    end

    def cache!
      top_most_redirect.trace_down.each(&:cache_jumps!)
    end

    def top_most_redirect
      @redirect.trace_up.first
    end

    def already_on_top?
      @redirect == top_most_redirect
    end
  end
end
