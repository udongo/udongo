class RedirectsController < ActionController::Base
  def catch_all
    redirect = ::Redirect.find_by(source_uri: source_uri)

    if redirect
      redirect_to redirect.destination_uri, status: redirect.status_code
    else
      redirect_to page_not_found_path
    end
  end

  private

  def source_uri
    if params[:path] && params[:path][0] != '/'
      params[:path] = "/#{params[:path]}"
    else
      params[:path]
    end
  end

  def snippet(identifier)
    ::Snippet.find_in_cache(identifier).decorate
  end
  helper_method :snippet
end
