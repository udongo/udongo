class Backend::AdminsController < Backend::BaseController
  before_action :find_admin, only: [:show, :edit, :update, :destroy]
  before_action -> { breadcrumb.add t('b.admins'), backend_admins_path }

  def index
    @admins = Admin.all
  end

  def show
    redirect_to edit_backend_admin_path(@admin)
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new allowed_params

    if @admin.save
      redirect_to backend_admins_path, notice: translate_notice(:added, :admin)
    else
      render :new
    end
  end

  def update
    if @admin.update_attributes allowed_params
      redirect_to backend_admins_path, notice: translate_notice(:changes_saved)
    else
      render :edit
    end
  end

  def destroy
    @admin.destroy
    redirect_to backend_admins_path, notice: translate_notice(:deleted, :admin)
  end

  private

  def find_admin
    @admin = Admin.find params[:id]
  end

  def allowed_params
    params[:admin].permit(
      :first_name, :last_name, :email, :password, :password_confirmation
    )
  end

  def password_required?
    @admin.new_record?
  end
  helper_method :password_required?
end
