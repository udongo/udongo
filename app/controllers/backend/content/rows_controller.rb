class Backend::Content::RowsController < BackendController
  include Concerns::Backend::PositionableController
  before_action :find_model, only: [:update_position, :move_up, :move_down, :destroy]

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
    @row.move_higher
    redirect_back_to_content
  end

  def move_down
    @row.move_lower
    redirect_back_to_content
  end

  def destroy
    @row.destroy
    redirect_back_to_content('content-rows')
  end

  private

  def find_model
    @row = ::ContentRow.find params[:id]
  end

  def content_path(instance, locale, anchor)
    path = "edit_translation_backend_#{instance.class.to_s.downcase}_path"
    send(path, instance, locale, anchor: anchor)
  end

  def redirect_back_to_content(anchor = nil)
    anchor = "content-row-#{@row.id}" unless anchor.present?
    redirect_to content_path(@row.rowable, @row.locale, anchor)
  end
end
