class RedirectsController < ActionController::Base
  def go
    redirect = Redirect.find_by(source_uri: source_uri)

    if redirect && redirect.enabled?
      redirect.used!
      redirect_to redirect.destination_uri, status: redirect.status_code
    else
      render plain: 'No such redirect or disabled.', status: 404
    end
  end

  private

  def source_uri
    "/go/#{params[:slug]}"
  end
end
