class Backend::SessionsController < BackendController
  skip_before_action :check_login
  layout 'backend/login'

  def create
    admin = Admin.find_by(email: params[:session][:email])

    if admin && admin.authenticate(params[:session][:password])
      session[:admin_id] = admin.id

      redirect_to session[:backend_redirect] ? session[:backend_redirect] : backend_path
    else
      flash.now.alert = t 'b.msg.incorrect_login'
      render :new
    end
  end

  def destroy
    session[:admin_id] = nil
    redirect_to new_backend_session_path
  end
end
