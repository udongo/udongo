class Backend::RedirectsController < BackendController
  include Concerns::Backend::PositionableController
  include Concerns::Backend::TranslatableController

  before_action -> { breadcrumb.add t('b.redirects'), backend_redirects_path }
  before_action :find_model, only: [:edit, :update, :destroy]

  def index
    @search = ::Redirect.ransack params[:q]
    @redirects = @search.result distinct: true
  end

  def new
    @redirect = ::Redirect.new(status_code: 301).decorate
  end

  def create
    @redirect = ::Redirect.new allowed_params

    if @redirect.save
      redirect_to backend_redirects_path, notice: translate_notice(:added, :redirect)
    else
      render :new
    end
  end

  def destroy
    @redirect.destroy
    redirect_to backend_redirects_path, notice: translate_notice(:deleted, :redirect)
  end

  def update
    if @redirect.update_attributes allowed_params
      redirect_to backend_redirects_path, notice: translate_notice(:edited, :redirect)
    else
      render :edit
    end
  end

  private

  def allowed_params
    params.require(:redirect).permit(
      :source_uri, :destination_uri, :status_code
    )
  end

  def find_model
    @redirect = ::Redirect.find(params[:id]).decorate
  end

  def translation_form
    Backend::RedirectTranslationForm.new(
      redirect: find_model,
      translation: find_model.translation(params[:translation_locale])
    )
  end
end
