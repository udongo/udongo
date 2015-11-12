class Backend::WebserverController < BackendController
  def restart
    `touch tmp/restart.txt`
    redirect_to backend_path
  end
end
