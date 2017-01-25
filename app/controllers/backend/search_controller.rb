class Backend::SearchController < Backend::BaseController
  def query
    @results = Udongo::Search::Backend.new(params[:query]).search
    render json: { results: @results }
  end
end
