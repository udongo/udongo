class Backend::ImageCollectionsController < Backend::BaseController
  before_action :find_model, only: [:show, :edit, :update, :destroy]
  before_action -> { breadcrumb.add t('b.image_collections'), backend_image_collections_path }

  def index
    @image_collections = ImageCollection.order(:description)
  end

  def show
    redirect_to edit_backend_image_collection_path(@model)
  end

  def new
    @model = ImageCollection.new
  end

  def create
    @model = ImageCollection.new(allowed_params)

    if @model.save
      redirect_to edit_backend_image_collection_path(@model),
                  notice: translate_notice(:added, :image_collection)
    else
      render :new
    end
  end

  def update
    if @model.update_attributes allowed_params
      redirect_to backend_image_collections_path, notice: translate_notice(:edited, :image_collection)
    else
      render :edit
    end
  end

  def destroy
    @model.destroy
    redirect_to backend_image_collections_path, notice: translate_notice(:deleted, :image_collection)
  end

  private

  def find_model
    @model = ImageCollection.find(params[:id])
  end

  def allowed_params
    params[:image_collection].permit(:identifier, :description)
  end
end
