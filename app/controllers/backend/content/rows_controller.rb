class Backend::Content::RowsController < Backend::BaseController
  include Concerns::Backend::PositionableController
  before_action :find_model, except: [:new]
  layout 'backend/lightbox'

  def new
    if params[:klass] && params[:id] && params[:locale]
      instance = params[:klass].constantize.find params[:id]
      row = instance.content_rows.create!(locale: params[:locale])

      redirect_to content_path(instance, params[:locale], "content-row-#{row.id}")
    else
      render text: 'Insufficient params. Please provide klass, id and locale.'
    end
  end

  def update
    if @row.update_attributes allowed_params
      render 'backend/lightbox_saved'
    else
      render :edit
    end
  end

  def horizontal_alignment
    align = params[:align].to_s
    align = 'left' unless %w(left center right).include?(align)
    @row.update_attribute :horizontal_alignment, align

    redirect_back_to_content
  end

  def vertical_alignment
    align = params[:align].to_s
    align = 'top' unless %w(top center bottom).include?(align)
    @row.update_attribute :vertical_alignment, align

    redirect_back_to_content
  end

  def toggle_full_width
    @row.update_attribute :full_width, !@row.full_width?
    redirect_back_to_content
  end

  def destroy
    @row.destroy
    redirect_back_to_content('content-rows')
  end

  private

  def find_model
    @row = ContentRow.find params[:id]
  end

  def content_path(instance, locale, anchor)
    path = "edit_translation_backend_#{instance.class.to_s.underscore}_path"
    send(path, instance, locale, anchor: anchor)
  end

  def redirect_back_to_content(anchor = nil)
    anchor = "content-row-#{@row.id}" unless anchor.present?
    redirect_to content_path(@row.rowable, @row.locale, anchor)
  end

  def allowed_params
    params.require(:content_row).permit(
      :background_color, :margin_top, :margin_bottom, :padding_top,
      :padding_bottom, :no_gutters
    )
  end
end
