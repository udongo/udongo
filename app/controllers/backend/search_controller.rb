class Backend::SearchController < Backend::BaseController
  def query
    @results = Udongo::Search::Backend.new(params[:query]).search
    raise 'stop'
  end
end
