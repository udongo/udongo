class Backend::ImageCollections::BaseController < Backend::BaseController
  before_action :find_image_collection
  before_action do
    breadcrumb.add t('b.image_collections'), backend_image_collections_path
    breadcrumb.add @image_collection.description, edit_backend_image_collection_path(@image_collection)
  end

  def find_image_collection
    @image_collection = ImageCollection.find params[:image_collection_id]
  end
end
