class Backend::Content::Rows::VideosController < Backend::BaseController
  include Concerns::Backend::ContentTypeController

  model ContentVideo
  allowed_params :url, :aspect_ratio, :caption
end
