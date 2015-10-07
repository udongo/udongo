class Backend::NavigationsController < BackendController
  before_action -> { breadcrumb.add t('b.navigation'), backend_navigations_path }

  def index
    @navigations = ::Navigation.all
  end
end
