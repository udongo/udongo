class Backend::FormsController < BackendController
  def index
    @forms = Form.all
  end
end
