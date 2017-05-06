class Backend::UsersController < Backend::BaseController
  include Concerns::PaginationController

  before_action :find_model, only: [:show, :edit, :update, :destroy]
  before_action -> { breadcrumb.add t('b.users'), backend_users_path }

  def index
    @search = User.ransack params[:q]
    @users = @search.result(distinct: true).order(:last_name, :first_name).page(page_number).per_page(per_page)
  end

  def show
    redirect_to edit_backend_user_path(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new allowed_params

    if @user.save
      redirect_to backend_users_path, notice: translate_notice(:added, :user)
    else
      render :new
    end
  end

  def update
    if @user.update_attributes allowed_params
      redirect_to backend_users_path, notice: translate_notice(:changes_saved)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to backend_users_path, notice: translate_notice(:deleted, :user)
  end

  private

  def find_model
    @user = User.find params[:id]
  end

  def allowed_params
    params[:user].permit(
      :first_name, :last_name, :email, :active, :password, :password_confirmation
    )
  end
end
