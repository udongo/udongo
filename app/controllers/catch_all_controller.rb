class CatchAllController < ActionController::Base
  def resolve
    redirect = ::Redirect.find_by(source_uri: request.path)

    if redirect && redirect.enabled?
      redirect.used!
      redirect_to redirect.destination_uri, status: redirect.status_code
    else
      render text: 'Page not found', status: 404
    end
  end
end
