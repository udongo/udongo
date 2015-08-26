class RedirectsController < ActionController::Base
  def go
    redirect = ::Redirect.find_by!(source_uri: source_uri)
    redirect_to redirect.destination_uri, status: redirect.status_code
  end

  private

  def source_uri
    "/go/#{params[:slug]}"
  end
end
