class Backend::TagsController < Backend::BaseController
  include Concerns::Backend::TranslatableController
  include Concerns::PaginationController

  before_action :find_model, only: [:show, :edit, :update, :destroy]
  before_action -> { breadcrumb.add t('b.tags'), backend_tags_path }

  def index
    @search = Tag.ransack params[:q]
    @tags = @search.result(distinct: true).order(:name).page(page_number).per_page(15)
  end

  def show
    redirect_to edit_backend_tag_path(@tag)
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(allowed_params)

    if @tag.save
      redirect_to edit_translation_backend_tag_path(
                    @tag,
                    translation_locale: default_app_locale,
                    notice: translate_notice(:added, :article)
                  )
    else
      render :new
    end
  end

  def destroy
    @tag.destroy
    redirect_to backend_tags_path, notice: translate_notice(:deleted, :tag)
  end

  def update
    if @tag.update_attributes allowed_params
      redirect_to backend_tags_path, notice: translate_notice(:edited, :tag)
    else
      render :edit
    end
  end

  private

  def allowed_params
    params.require(:tag).permit(:locale, :name, :slug)
  end

  def find_model
    @tag = Tag.find params[:id]
  end

  def translation_form
    Backend::TagTranslationForm.new(
      @model,
      @model.translation(params[:translation_locale]),
      @model.seo(params[:translation_locale])
    )
  end
end
