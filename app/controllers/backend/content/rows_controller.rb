class Backend::Content::RowsController < BackendController
  def new
    if params[:klass] && params[:id] && params[:locale]
      instance = params[:klass].constantize.find params[:id]
      row = instance.content_rows.create!(locale: params[:locale])

      redirect_to content_path(instance, params[:locale], "content-row-#{row.id}")
    else
      render text: 'Insufficient params. Please provide klass, id and locale.'
    end
  end

  def move_up
    @row = ::ContentRow.find params[:id]
    @row.move_higher

    redirect_to content_path(@row.rowable, @row.locale, "content-row-#{@row.id}")
  end

  def move_down
    @row = ::ContentRow.find params[:id]
    @row.move_lower

    redirect_to content_path(@row.rowable, @row.locale, "content-row-#{@row.id}")
  end

  def destroy
    row = ::ContentRow.find params[:id]
    row.destroy

    redirect_to content_path(row.rowable, row.locale, 'content-rows')
  end

  private

  def content_path(instance, locale, anchor)
    path = "edit_translation_backend_#{instance.class.to_s.downcase}_path"
    send(path, instance, locale, anchor: anchor)
  end
end
