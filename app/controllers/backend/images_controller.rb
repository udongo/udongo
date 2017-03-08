class Backend::ImagesController < Backend::BaseController
  before_action :find_model
  before_action :init_image, only: [:index, :new, :create]
  layout 'backend/lightbox'

  def index
    @search = Asset.ransack params[:q]
    @assets = @search.result(distinct: true).image.where.not(id: @model.images.pluck(:asset_id)).order('id DESC')
  end

  def create
    @image.build_asset
    @image.asset.filename = params[:image][:asset][:filename]
    @image.asset.description = params[:image][:asset][:description]

    if @image.asset.filename && @image.asset.filename.content_type.to_s.include?('image') && @image.save
      redirect_images_overview(:added)
    else
      @image.errors.add :filename, 'Ignore me'
      render :new
    end
  end

  def link
    @model.images.create(asset: Asset.find(params[:asset_id]))
    redirect_images_overview(:added)
  end

  def unlink
    @model.images.find_by(asset_id: params[:asset_id]).destroy
    redirect_images_overview(:deleted)
  end

  private

  def find_model
    begin
      @model ||= params[:klass].constantize.find params[:id]
    rescue
      redirect_to backend_path
    end
  end

  def allowed_params
    params[:image].permit(asset_attributes: [:filename, :description])
  end

  def redirect_images_overview(action)
    redirect_to send("backend_#{@model.class.name.underscore}_images_path", @model),
                notice: translate_notice(action, :image)
  end

  def init_image
    @image = @model.images.new
  end
end
