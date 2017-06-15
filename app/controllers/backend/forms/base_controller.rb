class Backend::Forms::BaseController < Backend::BaseController
  before_action :find_form

  private

  def find_form
    @form = Form.find(params[:form_id]).decorate
  end
end
