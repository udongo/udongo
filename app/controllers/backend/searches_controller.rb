class Backend::SearchesController < Backend::BaseController
  before_action -> { breadcrumb.add t('b.searches'), backend_searches_path }

  def index
    @searches = ::Search.all
  end

  def destroy_all
    @search.destroy_all
    redirect_to backend_searches_path, notice: translate_notice(:deleted, :search)
  end
end
