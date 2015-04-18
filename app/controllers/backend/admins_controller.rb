class Backend::AdminsController < BackendController
  def index
    @admins = ::Admin.all
  end

  def new
    @admin = ::Admin.new
  end

  def create
    @admin = ::Admin.new allowed_params

    if @admin.save
      redirect_to backend_admins_path, notice: t('b.msg.admins.added')
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def allowed_params
    params[:admin].permit(
      :first_name, :last_name, :email, :password, :password_confirmation
    )
  end
end
