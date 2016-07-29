class Backend::SnippetsController < BackendController
  include Concerns::Backend::TranslatableController

  before_action :find_model, only: [:edit, :update]
  before_action -> { breadcrumb.add t('b.snippets'), backend_snippets_path }

  def index
    @snippets = Snippet.order(:description)
  end

  def new
    @form = Backend::SnippetForm.new
  end

  def create
    @form = Backend::SnippetForm.new

    if @form.save params[:snippet]
      redirect_to edit_translation_backend_snippet_path(@form.snippet, translation_locale: default_locale),
                  notice: translate_notice(:added, :snippet)
    else
      render :new
    end
  end

  def edit
    @form = Backend::SnippetForm.new(@model)
  end

  def update
    @form = Backend::SnippetForm.new(@model)

    if @form.save params[:snippet]
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

  def translation_form
    Backend::SnippetTranslationForm.new(@model, @model.translation(params[:translation_locale]))
  end
end
