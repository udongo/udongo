class Backend::WebserverController < BackendController
  def restart
    `touch tmp/restart.txt`
    redirect_to backend_path, notice: t('b.msg.webserver.restarted')
  end
end
