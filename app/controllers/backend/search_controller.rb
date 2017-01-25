class Backend::SearchController < Backend::BaseController
  def query
    @results = Udongo::Search::Backend.new(params[:term], controller: self).search
    render json: @results
  end
end
