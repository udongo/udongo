class Backend::Content::Rows::ColumnsController < BackendController
  before_action :find_row
  before_action :find_column, only: [:edit, :update, :move_up, :move_down, :destroy]
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

  def update
    if @column.update_attributes allowed_params
      redirect_to cancel_url
    else
      render :edit
    end
  end

  def move_up
    @column.move_higher
    redirect_to cancel_url
  end

  def move_down
    @column.move_lower
    redirect_to cancel_url
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
    params.require(:content_column).permit(
      :width_xs, :width_sm, :width_md, :width_lg, :width_xl, :content_type
    )
  end

  def redirect_to_edit(column)
    redirect_to send("edit_backend_content_#{column.content.decorate.content_type}_path", column.content)
  end

  def cancel_url
    instance = @row.rowable
    path = "edit_translation_backend_#{instance.class.to_s.downcase}_path"
    send(path, instance, @row.locale, anchor: "content-row-#{@row.id}")
  end
  helper_method :cancel_url
end
