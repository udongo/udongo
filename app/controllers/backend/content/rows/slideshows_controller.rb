class Backend::Content::Rows::SlideshowsController < Backend::BaseController
  include Concerns::Backend::ContentTypeController

  model ContentSlideshow
  allowed_params :image_collection_id, :autoplay, :slide_interval

  def image_collections
    ImageCollection.order(:description).map { |c| [c.description, c.id] }
  end
  helper_method :image_collections
end
