class Backend::RedirectsController < BackendController
  include Concerns::Backend::PositionableController
  include Concerns::Backend::TranslatableController

  before_action -> { breadcrumb.add t('b.redirects'), backend_redirects_path }
  before_action :find_model, only: [:edit, :update, :destroy]

  def index
    @redirects = ::Redirect.all
  end

  def new
    @redirect = ::Redirect.new.decorate
  end

  private

  def find_model
    @redirect = ::Redirect.find params[:id]
  end

  def translation_form
    Backend::RedirectTranslationForm.new(
      redirect: find_model,
      translation: find_model.translation(params[:translation_locale])
    )
  end
end
