class Backend::SnippetsController < BackendController
  include Concerns::Backend::TranslatableController

  before_action :find_model, only: [:edit, :update, :destroy]
  before_action -> { breadcrumb.add t('b.snippets'), backend_snippets_path }

  def index
    @snippets = ::Snippet.all
  end

  def new
    @model = ::Snippet.new
  end

  def create
    @model = ::Snippet.new allowed_params

    if @model.save
      redirect_to edit_translation_backend_snippet_path(@model, translation_locale: default_locale), notice: translate_notice(:added, :snippet)
    else
      render :new
    end
  end

  def update
    if @model.update_attributes(allowed_params)
      redirect_to edit_backend_snippet_path(@model), notice: translate_notice(:edited, :snippet)
    else
      render :edit
    end
  end

  def destroy
    @model.destroy
    redirect_to backend_snippets_path, notice: translate_notice(:deleted, :snippet)
  end

  private

  def find_model
    @model = ::Snippet.find params[:id]
  end

  def translation_form
    Backend::SnippetTranslationForm.new(
      snippet: @model,
      translation: @model.translation(params[:translation_locale])
    )
  end

  def allowed_params
    params.require('snippet').permit(:identifier, :description)
  end
end
