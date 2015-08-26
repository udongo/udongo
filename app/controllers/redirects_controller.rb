class RedirectsController < ActionController::Base
  def go
    redirect = ::Redirect.find_by(source_uri: source_uri)

    if redirect && redirect.enabled?
      redirect_to redirect.destination_uri, status: redirect.status_code
    else
      render text: 'No such redirect or disabled.'
    end
  end

  private

  def source_uri
    "/go/#{params[:slug]}"
  end
end
