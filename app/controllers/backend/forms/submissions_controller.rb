class Backend::Forms::SubmissionsController < Backend::Forms::BaseController
  include Concerns::PaginationController
  before_action :find_form

  def index
    @filter = Udongo::Forms::SubmissionFilter.search(@form, params[:q])
    @submissions = paginate(@filter.result).decorate
  end

  private

  def find_form
    @form ||= Form.find(params[:form_id].to_i).decorate
  end
end
