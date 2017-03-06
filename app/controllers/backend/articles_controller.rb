class Backend::ArticlesController < Backend::BaseController
  include Concerns::Backend::TranslatableController
  include Concerns::PaginationController

  before_action :find_model, only: [:edit, :update]
  before_action -> { breadcrumb.add t('b.articles'), backend_articles_path }

  def index
    @articles = paginate Article.all
  end

  def new
    @model = Article.new
  end

  def create
    @model = Article.new(allowed_params)

    if @model.save
      redirect_to edit_translation_backend_article_path(@model, translation_locale: default_app_locale),
                  notice: translate_notice(:added, :article)
    else
      render :new
    end
  end

  def update
    if @model.update_attributes allowed_params
      redirect_to edit_backend_article_path(@model), notice: translate_notice(:edited, :article)
    else
      render :edit
    end
  end

  def destroy
    # render json: { trashed: @model.destroy }
  end

  private

  def find_model
    @model = Article.find(params[:id])
  end

  def allowed_params
    params[:article].permit(:user_id, :press_release, :published_at, :visible)
  end

  def translation_form
    Backend::ArticleTranslationForm.new(
      @model,
      @model.translation(params[:translation_locale]),
      @model.seo(params[:translation_locale])
    )
  end
end