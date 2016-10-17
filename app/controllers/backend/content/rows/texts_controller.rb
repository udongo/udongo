class Backend::Content::Rows::TextsController < Backend::BaseController
  include Concerns::Backend::ContentTypeController

  model ContentText
  allowed_params :content
end
