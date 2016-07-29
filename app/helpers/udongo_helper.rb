module UdongoHelper
  # Before using: Put <%= yield(:javascripts) %> in the <head> of your app's frontend
  def javascript(file, target = :javascripts)
    js_asset_loader.view = self
    js_asset_loader.load_js file, target
  end

  def restart_webserver_button
    link_to I18n.t('b.restart_webserver'), backend_restart_webserver_path, class: 'btn btn-info', method: 'post'
  end

  # Before using: Put <%= yield(:stylesheets) %> in the <head> of your app's frontend
  def stylesheet(file, media = :screen)
    css_asset_loader.view = self
    css_asset_loader.load_css file, media
  end

  private

  def css_asset_loader
    @css_asset_loader ||= Udongo::Assets::Loader.new
  end

  def js_asset_loader
    @js_asset_loader ||= Udongo::Assets::Loader.new
  end
end
