class Backend::UsersController < Backend::BaseController
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action -> { breadcrumb.add t('b.users'), backend_users_path }

  def index
    @users = User.all
  end

  def show
    # TODO add the show action? Or just use edit with tabs?
    # redirect_to edit_backend_user_path(@user)
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

  def find_user
    @user = User.find params[:id]
  end

  def allowed_params
    params[:user].permit(
      :first_name, :last_name, :email, :password, :password_confirmation
    )
  end
end
