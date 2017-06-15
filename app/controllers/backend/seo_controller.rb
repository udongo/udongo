class Backend::SeoController < Backend::BaseController
  def slugify
    result = params[:value] ? params[:value].parameterize : nil
    render json: { result: result }
  end
end
