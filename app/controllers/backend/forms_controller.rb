class Backend::FormsController < Backend::BaseController
  before_action -> { breadcrumb.add t('b.forms'), backend_forms_path }

  def index
    @forms = Form.all
  end
end
