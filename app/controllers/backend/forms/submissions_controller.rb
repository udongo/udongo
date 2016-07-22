class Backend::Forms::SubmissionsController < Backend::Forms::BaseController
  include Concerns::PaginationController

  def index
    @filter = Udongo::Forms::SubmissionFilter.search(@form, params[:q])
    @submissions = paginate(@filter.result).decorate
  end
end
