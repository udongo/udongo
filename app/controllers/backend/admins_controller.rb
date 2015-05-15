class Backend::AdminsController < BackendController
  before_action :find_admin, only: [:edit, :update, :destroy]
  before_action -> { breadcrumb.add t('b.admins'), backend_admins_path }

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
    @admin = ::Admin.find params[:id]
  end

  def update
    @admin = ::Admin.find params[:id]

    if @admin.update_attributes allowed_params
      redirect_to backend_admins_path, notice: t('b.msg.changes_saved')
    else
      render :edit
    end
  end

  def destroy
    @admin.destroy
    redirect_to backend_admins_path, notice: t('b.msg.admins.deleted')
  end

  private

  def find_admin
    @admin = ::Admin.find params[:id]
  end

  def allowed_params
    params[:admin].permit(
      :first_name, :last_name, :email, :password, :password_confirmation
    )
  end
end
