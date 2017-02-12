class Backend::Users::BaseController < Backend::BaseController
  before_action :find_user
  before_action do
    breadcrumb.add t('b.users'), backend_users_path
    breadcrumb.add @user.full_name
  end

  def find_user
    @user = User.find params[:user_id]
  end
end
