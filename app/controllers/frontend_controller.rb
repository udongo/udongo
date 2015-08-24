class FrontendController < ActionController::Base
  layout 'frontend/application'

  def snippet(identifier)
    ::Snippet.find_in_cache(identifier).decorate
  end
  helper_method :snippet
end
