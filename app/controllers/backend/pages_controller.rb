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
    @form = Backend::PageForm.new(Page.new.decorate)
  end

  def create
    @form = Backend::PageForm.new(Page.new.decorate)

    if @form.save params[:page]
      redirect_to edit_backend_page_path(@form.page), notice: translate_notice(:added, :page)
    else
      render :new
    end
  end

  def edit
    @form = Backend::PageForm.new(@model)
  end

  def update
    @form = Backend::PageForm.new(@model)

    if @form.save params[:page]
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

  def translation_form
    Backend::PageTranslationForm.new(
      @model,
      @model.translation(params[:translation_locale]),
      @model.seo(params[:translation_locale])
    )
  end
end
