class Backend::PagesController < Backend::BaseController
  include Concerns::Backend::TranslatableController

  before_action :find_model, except: [:index, :new, :create]
  before_action -> { breadcrumb.add t('b.pages'), backend_pages_path }

  def index
    @pages = Page.all

    respond_to do |format|
      format.html
      format.json {
        render json: Udongo::Pages::Tree.new(self).data
      }
    end
  end

  def new
    @model = Page.new.decorate
  end

  def create
    @model = Page.new(allowed_params).decorate

    if @model.save
      redirect_to edit_backend_page_path(@model), notice: translate_notice(:added, :page)
    else
      render :new
    end
  end

  def update
    if @model.update_attributes allowed_params
      redirect_to edit_backend_page_path(@model), notice: translate_notice(:edited, :page)
    else
      render :edit
    end
  end

  def toggle_visibility
    @model.visible? ? @model.hide! : @model.show!
    render json: { toggled: @model }
  end

  def tree_drag_and_drop
    # TODO (Dave) - check if this page is draggable.
    render json: { moved: @model.set_position(params[:position], params[:parent_id]) }
  end

  def destroy
    # TODO (Dave) - check if this page may be destroyed.
    render json: { trashed: @model.destroy }
  end

  private

  def find_model
    @model = Page.find(params[:id]).decorate
  end

  def allowed_params
    params[:page].permit(:description, :parent_id, :visible)
  end

  def translation_form
    Backend::PageTranslationForm.new(
      @model,
      @model.translation(params[:translation_locale]),
      @model.seo(params[:translation_locale])
    )
  end
end
