class Backend::Content::Rows::FormsController < Backend::BaseController
  include Concerns::Backend::ContentTypeController

  model ContentForm
  allowed_params :form_id

  def forms_collection
    Form.order(:description).map { |f| [f.description, f.id] }
  end
  helper_method :forms_collection
end
