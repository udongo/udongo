class Backend::Content::Rows::ColumnsController < BackendController
  before_action :find_row
  before_action :find_column, only: [:edit, :destroy]
  layout 'backend/lightbox'

  def new
    @column = @row.columns.new
    cancel_url
  end

  def create
    @column = @row.columns.new allowed_params

    if @column.save
      @column.content = @column.content_type.constantize.create!
      @column.save!

      redirect_to_edit @column
    else
      render :new
    end
  end

  # TODO make it possible to edit the column settings (only the width)
  def edit
    raise 'foo'
  end

  def destroy
    @column.destroy

    path = "edit_translation_backend_#{@column.row.rowable.class.to_s.downcase}_path"
    redirect_to send(path, @column.row.rowable, @column.row.locale, anchor: "content-row-#{@column.row.id}")
  end

  private

  def find_row
    @row = ::ContentRow.find params[:row_id]
  end

  def find_column
    @column = ::ContentColumn.find params[:id]
  end

  def allowed_params
    params.require(:content_column).permit(:width, :content_type)
  end

  def redirect_to_edit(column)
    if column.content.is_a?(ContentText)
      redirect_to edit_backend_content_text_path(column.content)

    elsif column.content.is_a?(ContentImage)
      redirect_to edit_backend_content_image_path(column.content)

    else
      raise "No such content type #{column.content.class}"
    end
  end

  def cancel_url
    instance = @row.rowable
    path = "edit_translation_backend_#{instance.class.to_s.downcase}_path"
    send(path, instance, @row.locale, anchor: "content-row-#{@row.id}")
  end
  helper_method :cancel_url
end
