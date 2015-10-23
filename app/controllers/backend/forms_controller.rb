class Backend::FormsController < BackendController
  def index
    @forms = ::Form.all
  end

  def new
    @form = ::Form.new
  end
end
