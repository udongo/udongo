class Udongo::Redirects::DepthCacher
  def initialize(redirect)
    @redirect = redirect
  end

  def cache!
    top_most_redirect.trace_down.each(&:cache_depth!)
  end

  def top_most_redirect
    @redirect.trace_up.first
  end
end
