class Backend::Content::Rows::ImagesController < BackendController
  before_action :find_image
  layout 'backend/lightbox'

  def update
    if @image.update_attributes allowed_params
      redirect_to content_path
    else
      render :edit
    end
  end

  private

  def find_image
    @image = ::ContentImage.find params[:id]
  end

  def allowed_params
    params.require(:content_image).permit(:file, :caption, :url)
  end

  def content_path
    column = @image.column
    path = "edit_translation_backend_#{column.row.rowable.class.to_s.downcase}_path"
    send(path, column.row.rowable, locale, anchor: "content-row-#{column.row.id}")
  end
  helper_method :content_path
end
