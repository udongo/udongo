class Backend::Content::Rows::ImagesController < Backend::BaseController
  include Concerns::Backend::ContentTypeController

  model ContentImage
  allowed_params :file, :caption, :url
end
