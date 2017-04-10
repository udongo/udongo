class Backend::Forms::SubmissionsController < Backend::Forms::BaseController
  include Concerns::PaginationController

  before_action -> do
    breadcrumb.add t('b.forms'), backend_forms_path
    breadcrumb.add @form.identifier, edit_backend_form_path(@form)
    breadcrumb.add t('b.form_submissions')
  end

  def index
    @filter = Udongo::Forms::SubmissionFilter.search(@form, params[:q])
    @submissions = paginate(@filter.result)
  end

  def show
    @model = FormSubmission.find(params[:id].to_i)
  end
end
