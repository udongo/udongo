class Backend::Content::DuplicateController < Backend::BaseController
  before_action :find_model

  def execute
    duplicate
    redirect_back_to_edit_translation
  end

  private

  def find_model
    begin
      @model = params[:model].to_s.camelcase.constantize.find(params[:id])
    rescue
      redirect_to backend_path
    end
  end

  def source_locale
    if Udongo.config.i18n.app.locales.include?(params[:source_locale].to_s)
      params[:source_locale].to_s
    else
      raise "No valid source locale provided (#{params[:source_locale]})"
    end
  end

  def destination_locale
    if Udongo.config.i18n.app.locales.include?(params[:destination_locale].to_s)
      params[:destination_locale].to_s
    else
      raise "No valid destination locale provided (#{params[:destination_locale]})"
    end
  end

  def duplicate
    Udongo::FlexibleContent::DuplicateLocale.new(
      @model,
      source_locale,
      destination_locale
    ).execute!
  end

  def redirect_back_to_edit_translation
    path = "edit_translation_backend_#{@model.class.name.downcase}_path"
    redirect_to send(path, @model, destination_locale), notice: t('b.msg.flexible_content.duplicated')
  end
end
