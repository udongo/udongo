class Backend::FormSubmissionsController < BackendController
  before_action :find_form

  def index
    @submissions = FormSubmission.includes(:data).decorate
  end

  private

  def find_form
    @form ||= Form.find(params[:form_id].to_i).decorate
  end
end
