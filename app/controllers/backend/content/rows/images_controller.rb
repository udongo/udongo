class Backend::Content::Rows::ImagesController < BackendController
  include Concerns::Backend::ContentTypeController

  model ContentImage
  allowed_params :file, :caption, :url
end
