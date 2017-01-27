class Backend::SearchController < Backend::BaseController
  def query
    render json: Udongo::Search::Backend.new(params[:term], controller: self).search
  end
end
