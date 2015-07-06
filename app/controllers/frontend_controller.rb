class FrontendController < ActionController::Base
  layout 'frontend/application'

  def snippet(identifier)
    ::Snippet.find_by(identifier: identifier).decorate
  end
  helper_method :snippet
end
