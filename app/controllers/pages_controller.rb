class PagesController < FrontendController
  # TODO: How will we handle 404?
  # First we could look for a Page instance called 404.
  # If it exists, we render it. If it doesn't, we render the fallback?
  def not_found
    render status: 404, layout: 'frontend/application'
  end
end
