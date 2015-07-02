class BackendController < ActionController::Base
  layout 'backend/application'
  before_action :default_locale, :check_login

  def breadcrumb
    @breadcrumb ||= Udongo::Breadcrumb.new
  end
  helper_method :breadcrumb

  def current_admin
    @current_admin ||= Admin.find(session[:admin_id]) if session[:admin_id]
  end
  helper_method :current_admin

  def default_locale
    I18n.locale = :nl
  end

  def translate_notice(notice, actor)
    I18n.t("b.msg.#{notice}") % I18n.t("b.#{actor}")
  end

  private

  def check_login
    unless current_admin
      session[:backend_redirect] = request.url
      redirect_to new_backend_session_path
    end
  end
end
