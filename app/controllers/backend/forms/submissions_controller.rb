class Backend::Forms::SubmissionsController < Backend::Forms::BaseController
  include Concerns::PaginationController

  before_action :find_model, except: [:index]
  before_action -> do
    breadcrumb.add t('b.forms'), backend_forms_path
    breadcrumb.add @form.description, edit_backend_form_path(@form)
  end

  def index
    @submissions = paginate(@form.submissions.order('id DESC'))
  end

  def destroy
    @model.destroy
    redirect_to backend_forms_path,
                notice: translate_notice(:deleted, :form_submission)
  end

  def find_model
    @model = FormSubmission.find(params[:id])
  end
end
