class Backend::Content::Rows::ColumnsController < BackendController
  before_action :find_row
  layout 'backend/lightbox'

  def new
    @column = @row.columns.new
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

  def edit
    raise 'foo'
  end

  private

  def find_row
    @row = ::ContentRow.find params[:row_id]
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
end
