class Backend::Articles::ImagesController < Backend::Articles::BaseController
  include Concerns::Backend::PositionableController

  before_action { breadcrumb.add t('b.images') }

  def index
    @images = @article.images
  end

  private

  def find_model
    @model = @article.images.find params[:id]
  end
end
