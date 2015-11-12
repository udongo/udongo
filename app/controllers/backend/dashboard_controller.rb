class Backend::DashboardController < BackendController
  def restart_webserver
    `touch tmp/restart.txt`
    redirect_to backend_path
  end
end
