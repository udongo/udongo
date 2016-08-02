class Backend::EmailTemplatesController < BackendController
  include Concerns::Backend::TranslatableController
  include Concerns::Backend::PositionableController

  before_action :find_model, only: [:edit, :update]
  before_action -> { breadcrumb.add t('b.email_templates'), backend_email_templates_path }

  def index
    @email_templates = EmailTemplate.all
  end

  def new
    @form = Backend::EmailTemplateForm.new(EmailTemplate.new)
  end

  def create
    @form = Backend::EmailTemplateForm.new(EmailTemplate.new)

    if @form.save params[:email_template]
      redirect_to edit_translation_backend_email_template_path(@form.email_template, translation_locale: default_locale), notice: translate_notice(:added, :email_template)
    else
      render :new
    end
  end

  def edit
    @form = Backend::EmailTemplateForm.new(@model)
  end

  def update
    @form = Backend::EmailTemplateForm.new(@model)

    if @form.save params[:email_template]
      redirect_to edit_backend_email_template_path(@model), notice: translate_notice(:edited, :email_template)
    else
      render :edit
    end
  end

  private

  def find_model
    @model = EmailTemplate.find params[:id]
  end

  def translation_form
    Backend::EmailTemplateTranslationForm.new(
      email_template: @model,
      translation: @model.translation(params[:translation_locale])
    )
  end
end
