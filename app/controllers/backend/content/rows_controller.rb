class Backend::Content::RowsController < BackendController
  def new
    if params[:klass] && params[:id] && params[:locale]
      instance = params[:klass].constantize.find params[:id]
      instance.content_rows.create!(locale: params[:locale])

      env["HTTP_REFERER"] += "#content-row-#{instance.content_rows.last.id}"
      redirect_to :back
    else
      render text: 'Insufficient params. Please provide klass, id and locale.'
    end
  end
end
