class Backend::EmailTemplatesController < BackendController
  include Concerns::Backend::TranslatableController

  before_action :find_model, only: [:edit, :update]
  before_action -> { breadcrumb.add t('b.email_templates'), backend_email_templates_path }

  def index
    @email_templates = ::EmailTemplate.order(:description)
  end

  def new
    @model = ::EmailTemplate.new
  end

  def create
    @model = ::EmailTemplate.new allowed_params

    if @model.save
      redirect_to edit_translation_backend_email_template_path(@model, translation_locale: default_locale), notice: translate_notice(:added, :email_template)
    else
      render :new
    end
  end

  def update
    if @model.update_attributes(allowed_params)
      redirect_to edit_backend_email_template_path(@model), notice: translate_notice(:edited, :email_template)
    else
      render :edit
    end
  end

  private

  def find_model
    @model = ::EmailTemplate.find params[:id]
  end

  def translation_form
    Backend::EmailTemplateTranslationForm.new(
      email_template: @model,
      translation: @model.translation(params[:translation_locale])
    )
  end

  def allowed_params
    params.require('email_template').permit(:identifier, :description, :from_name, :from_email)
  end
end
