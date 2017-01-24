module Udongo::Search
  # The goal of the Base class is to filter our indices on the given search
  # term. Further manipulation of individual index data into a meaningful
  # result set (think autocomplete results) is done by extending this class.
  #
  # Examples of class extensions could be:
  # Udongo::Search::Backend - included in Udongo
  # Udongo::Search::Frontend
  # Udongo::Search::Api
  #
  # The primary benefit in having these namespaced search interfaces is to
  # provide a way for the developer to have different result objects for
  # each resource.
  # An example: A search request for a specific Page instance in the frontend
  # will typically return a link to said page. However, in search requests made
  # in the backend for the same Page instance, you'd expect a link to a form in
  # the backend Page module where you can edit the page's contents.
  #
  # However these result objects are structured are also up to the developer.
  class Base
    attr_reader :term

    def initialize(term)
      # Filtering term should happen in classes extending the Base class.
      @term = term
    end

    def indices
      return [] unless term.present?

      # Having the searchmodules sorted by weight returns indices in the
      # correct order.
      @indices ||= SearchModule.weighted.inject([]) do |stack, m|
        stack << m.indices.where('search_indices.value REGEXP ?', term)
      end.flatten
    end
  end
end
