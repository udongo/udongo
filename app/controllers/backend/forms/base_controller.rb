class Backend::Forms::BaseController < BackendController
  before_action :find_form

  before_action -> do
    breadcrumb.add t('b.forms'), backend_forms_path
    breadcrumb.add @form.description
  end

  private

  def find_form
    @form ||= Form.find(params[:form_id].to_i).decorate
  end
end
