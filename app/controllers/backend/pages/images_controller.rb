class Backend::Pages::ImagesController < Backend::Pages::BaseController
  include Concerns::Backend::PositionableController

  before_action { breadcrumb.add t('b.images') }

  def index
    @images = @page.images
  end

  private

  def find_model
    @model = @page.images.find params[:id]
  end
end
