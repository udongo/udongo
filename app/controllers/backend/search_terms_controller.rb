class Backend::SearchTermsController < Backend::BaseController
  before_action -> { breadcrumb.add t('b.search_terms'), backend_search_terms_path }

  def index
    @search_terms = ::SearchTerm.select('*, COUNT(1) as total')
                                .group('locale, term')
  end

  def destroy_all
    @search.destroy_all
    redirect_to backend_search_terms_path, notice: translate_notice(:deleted, :search)
  end
end
