class Backend::SearchSynonymsController < Backend::BaseController
  include Concerns::PaginationController

  before_action -> { breadcrumb.add t('b.search_synonyms'), backend_search_synonyms_path }
  before_action :find_model, only: [:edit, :update, :destroy]

  def index
    @search_synonyms = paginate(SearchSynonym.all)
  end

  def new
    @search_synonym = SearchSynonym.new
  end

  def create
    @search_synonym = SearchSynonym.new(allowed_params)

    if @search_synonym.save
      redirect_to backend_search_synonyms_path, notice: translate_notice(:added, :search_synonym)
    else
      render :new
    end
  end

  def destroy
    @search_synonym.destroy
    redirect_to backend_search_synonyms_path, notice: translate_notice(:deleted, :search_synonym)
  end

  def update
    if @search_synonym.update_attributes allowed_params
      redirect_to backend_search_synonyms_path, notice: translate_notice(:edited, :search_synonym)
    else
      render :edit
    end
  end

  private

  def allowed_params
    params.require(:search_synonym).permit(
      :locale, :term, :synonyms
    )
  end

  def find_model
    @search_synonym = SearchSynonym.find(params[:id].to_i)
  end
end
