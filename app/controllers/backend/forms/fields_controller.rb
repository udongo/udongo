class Backend::Forms::FieldsController < Backend::Forms::BaseController
  include Concerns::Backend::TranslatableController
  include Concerns::Backend::PositionableController
  include Concerns::PaginationController

  before_action :find_model, only: [:edit, :update, :destroy]
  before_action -> do
    breadcrumb.add t('b.forms'), backend_forms_path
    breadcrumb.add @form.description, edit_backend_form_path(@form)
  end

  def new
    @field = @form.fields.new
  end

  def create
    @field = @form.fields.new(allowed_params)

    if @field.save
      redirect_to edit_translation_backend_form_field_path(@form, @field, locale),
        notice: translate_notice(:added, :form_field)
    else
      render :new
    end
  end

  def update
    if @field.update_attributes allowed_params
      redirect_to backend_form_fields_path(@form),
                  notice: translate_notice(:edited, :form_field)
    else
      render :edit
    end
  end

  def destroy
    @field.destroy
    redirect_to backend_form_fields_path(@form),
                notice: translate_notice(:deleted, :form_field)
  end

  private

  def allowed_params
    params[:form_field].permit(
      :identifier, :field_type, :presence, :email, :external_reference
    )
  end

  def find_model
    @field ||= @form.fields.find(params[:id])
  end

  def translation_form
    Backend::FormFieldTranslationForm.new(
      @field,
      @field.translation(params[:translation_locale])
    )
  end

  def translatable_path
    method = "edit_translation_backend_#{model_name}_path"
    @translatable_path || send(method, @form, @model, params[:translation_locale])
  end
end
