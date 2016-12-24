class Backend::SnippetsController < Backend::BaseController
  include Concerns::Backend::TranslatableController

  before_action :find_model, only: [:edit, :update]
  before_action -> { breadcrumb.add t('b.snippets'), backend_snippets_path }

  def index
    @snippets = Snippet.order(:description)
  end

  def new
    @model = Snippet.new
  end

  def create
    @model = Snippet.new allowed_params

    if @model.save
      redirect_to edit_translation_backend_snippet_path(@model, translation_locale: default_app_locale),
                  notice: translate_notice(:added, :snippet)
    else
      render :new
    end
  end

  def update
    if @model.update_attributes allowed_params
      redirect_to edit_backend_snippet_path(@model),
                  notice: translate_notice(:edited, :snippet)
    else
      render :edit
    end
  end

  private

  def find_model
    @model = Snippet.find params[:id]
  end

  def allowed_params
    params[:snippet].permit(:identifier, :description)
  end

  def translation_form
    Backend::SnippetTranslationForm.new(
      @model,
      @model.translation(params[:translation_locale])
    )
  end
end
