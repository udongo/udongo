class Backend::FormSubmissionsController < BackendController
  before_action :find_form

  private

  def find_form
    @form ||= Form.find(params[:form_id].to_i).decorate
  end
end
