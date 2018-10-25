class Backend::RedirectsController < Backend::BaseController
  include Concerns::PaginationController

  before_action -> { breadcrumb.add t('b.redirects'), backend_redirects_path }
  before_action :find_model, only: [:edit, :update, :destroy, :test]

  def index
    @search = Redirect.ransack params[:q]
    @redirects = paginate(@search.result(distinct: true).order('times_used DESC'))
  end

  def new
    @redirect = Redirect.new(status_code: 301).decorate
  end

  def create
    @redirect = Redirect.new(allowed_params).decorate

    if @redirect.save
      redirect_to backend_redirects_path, notice: translate_notice(:added, :redirect)
    else
      render :new
    end
  end

  def destroy
    @redirect.destroy
    redirect_to :back, notice: translate_notice(:deleted, :redirect)
  end

  def edit
    session['redirect_search_params'] = search_params
  end

  def update
    if @redirect.update_attributes allowed_params
      redirect_to backend_redirects_path(session[:redirect_search_params]), notice: translate_notice(:edited, :redirect)
    else
      render :edit
    end
  end

  def test
    if @redirect.works?(base_url: request.base_url)
      @redirect.working!
      redirect_to :back, notice: test_notice(:works)
    else
      @redirect.broken!
      redirect_to :back, alert: test_notice(:broken)
    end
  end

  def search_params
    hash = { q: nil }
    hash[:q] = params[:q].to_hash if params[:q]
    hash[:page] = params[:page] if params[:page]
    hash
  end
  helper_method :search_params

  private

  def allowed_params
    params.require(:redirect).permit(
      :source_uri, :destination_uri, :status_code, :disabled
    )
  end

  def find_model
    @redirect = Redirect.find(params[:id]).decorate
  end

  def test_notice(key)
    t("b.msg.redirects.#{key}",
      source: @redirect.source_uri,
      destination: @redirect.destination_uri
     )
  end
end
