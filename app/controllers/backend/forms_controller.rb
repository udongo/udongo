class Backend::FormsController < Backend::BaseController
  include Concerns::Backend::TranslatableController

  before_action :find_model, only: [:edit, :update, :destroy]
  before_action -> { breadcrumb.add t('b.forms'), backend_forms_path}

  def index
    @forms = Form.all
  end

  def new
    @model = Form.new
  end

  def create
    @model = Form.new(allowed_params)

    if @model.save
      redirect_to backend_forms_path, notice: translate_notice(:added, :form)
    else
      render :new
    end
  end

  def edit
    @model = Form.find(params[:id])
  end

  def update
    if @model.update_attributes allowed_params
      redirect_to backend_forms_path, notice: translate_notice(:edited, :form)
    else
      render :edit
    end
  end

  def destroy
    @model.destroy if @model.deletable?
    redirect_to backend_forms_path, notice: translate_notice(:deleted, :form)
  end

  private

  def allowed_params
    params[:form].permit(:identifier, :description)
  end

  def find_model
    @model = Form.find(params[:id].to_i)
  end

  def translation_form
    Backend::FormTranslationForm.new(
      @model,
      @model.translation(params[:translation_locale])
    )
  end
end
