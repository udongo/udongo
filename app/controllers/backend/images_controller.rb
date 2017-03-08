class Backend::ImagesController < Backend::BaseController
  before_action :find_model, only: [:index, :link, :unlink]

  def index
    @search = Asset.ransack params[:q]
    @assets = @search.result(distinct: true).image.where.not(id: @model.images.pluck(:asset_id)).order('id DESC')
  end

  def link
    @model.images.create(asset: Asset.find(params[:asset_id]))
    redirect_to backend_article_images_path(@model), notice: translate_notice(:added, :image)
  end

  def unlink
    @model.images.find_by!(asset_id: Asset.find(params[:asset_id])).destroy
    redirect_to backend_article_images_path(@model), notice: translate_notice(:deleted, :image)
  end

  private

  def find_model
    begin
      @model ||= params[:klass].constantize.find params[:id]
    rescue
      redirect_to backend_path
    end
  end
end
