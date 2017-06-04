class Backend::TagsController < Backend::BaseController
  include Concerns::PaginationController

  before_action -> { breadcrumb.add t('b.tags'), backend_tags_path }
  before_action :find_model, only: [:show, :edit, :update, :destroy]

  def index
    @search = Tag.ransack params[:q]
    @tags = @search.result(distinct: true).order(:name).page(page_number).per_page(per_page)
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(allowed_params)

    if @tag.save
      redirect_to backend_tags_path, notice: translate_notice(:added, :tag)
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
end
