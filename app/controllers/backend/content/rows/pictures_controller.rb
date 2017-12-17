class Backend::Content::Rows::PicturesController < Backend::BaseController
  include Concerns::Backend::ContentTypeController
  before_action :redirect_unless_has_asset, only: [:edit, :update]
  before_action :redirect_if_has_asset, only: [:link_or_upload, :link, :upload]
  before_action :prepare_upload, only: [:link_or_upload, :upload]

  model ContentPicture
  allowed_params :caption, :url, :disallow_resize

  def link
    @model.asset = Asset.find params[:asset_id]
    @model.save!

    redirect_to edit_backend_content_picture_path
  end

  def upload
    @asset.filename = params[:asset][:filename]
    @asset.description = params[:asset][:description]

    if @asset.filename && @asset.filename.content_type.to_s.include?('image') && @asset.save
      @model.asset = @asset
      @model.save

      redirect_to edit_backend_content_picture_path(@model)
    else
      @asset.errors.add :filename, t('b.msg.please_select_a_valid_image')
      render :link_or_upload
    end
  end

  private

  def redirect_unless_has_asset
    unless @model.asset
      redirect_to link_or_upload_backend_content_picture_path(@model)
    end
  end

  def redirect_if_has_asset
    if @model.asset
      redirect_to edit_backend_content_picture_path(@model)
    end
  end

  def prepare_upload
    @asset = Asset.new
    @search = Asset.ransack params[:q]
    @assets = @search.result(distinct: true).image.where.not(id: @model.asset_id).order('id DESC').limit(30)
  end
end
