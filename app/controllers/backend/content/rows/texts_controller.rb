class Backend::Content::Rows::TextsController < BackendController
  include Concerns::Backend::ContentTypeController

  model ::ContentText
  allowed_params :content
end
