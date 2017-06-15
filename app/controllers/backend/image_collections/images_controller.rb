class Backend::ImageCollections::ImagesController < Backend::ImageCollections::BaseController
  include Concerns::Backend::PositionableController

  before_action { breadcrumb.add t('b.images') }

  def index
    @images = @image_collection.images
  end

  private

  def find_model
    @model = @image_collection.images.find params[:id]
  end
end
