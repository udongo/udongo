class Backend::PagesController < BackendController
  include Concerns::Backend::TranslatableController

  before_action :find_model, only: [:edit, :update, :tree_drag_and_drop, :destroy]
  before_action -> { breadcrumb.add t('b.pages'), backend_pages_path }

  def index
    @pages = ::Page.all

    respond_to do |format|
      format.html
      format.json {
        render json: page_tree_data.to_json
      }
    end
  end

  def new
    @model = ::Page.new.decorate
  end

  def create
    @model = ::Page.new(params.require('page').permit(:description, :visible, :parent_id)).decorate

    if @model.save
      redirect_to edit_backend_page_path(@model), notice: translate_notice(:added, :page)
    else
      render :new
    end
  end

  def update
    if @model.update_attributes(params.require('page').permit(:description, :visible, :parent_id))
      redirect_to edit_backend_page_path(@model), notice: translate_notice(:edited, :page)
    else
      render :edit
    end
  end

  def tree_drag_and_drop
    render json: { moved: @model.set_position(params[:position], params[:parent_id]) }
  end

  def destroy
    render json: { trashed: @model.destroy }
  end

  def page_tree_data(parent_id: nil)
    ::Page.where(parent_id: parent_id).inject([]) do |data, p|
      hash = node_data p
      hash[:children] = page_tree_data(parent_id: p.id) if p.children.any?
      data << hash
    end
  end

  private

  def find_model
    @model = ::Page.find(params[:id]).decorate
  end

  def translation_form
    Backend::PageTranslationForm.new(
      page: @model,
      translation: @model.translation(params[:translation_locale]),
      seo: @model.seo(params[:translation_locale])
    )
  end

  def node_data(page)
    {
      text: page.description,
      type: :file,
      state: { selected: false },
      data: {
        id: page.id,
        url: edit_backend_page_path(page),
        delete_url: backend_page_path(page, format: :json),
        deletable: page.deletable?,
        draggable: page.draggable?,
        update_position_url: tree_drag_and_drop_backend_page_path(page)
      },
      children: []
    }
  end
end
