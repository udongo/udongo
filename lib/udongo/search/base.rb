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
  #
  # Example #1: A search request for a specific Page instance in the frontend
  # will typically return a link to said page. However, in search requests made
  # in the backend for the same Page instance, you'd expect a link to a form in
  # the backend Page module where you can edit the page's contents.
  #
  # Example #2: Some autocompletes in a frontend namespace might require an
  # image or a price to be included in its body.
  #
  # However these result objects are structured are also up to the developer.
  class Base
    attr_reader :term, :controller

    def initialize(term, controller: nil, namespace: nil)
      @term = Udongo::Search::Term.new(term, controller: controller)
      @controller = controller
      @namespace = namespace
    end

    def class_exists?(class_name)
      klass = Module.const_get(class_name)
      return klass.is_a?(Class)
    rescue NameError
      return false
    end

    def indices
      return [] unless term.present?

      # Having the searchmodules sorted by weight returns indices in the
      # correct order.
      @indices ||= SearchModule.weighted.inject([]) do |stack, m|
        # The group happens to make sure we end up with just 1 copy of
        # a searchable result Otherwise matches from both an indexed
        # Page#title and Page#description would be in the result set.
        stack << m.indices.where('search_indices.value REGEXP ?', term.value)
          .group([:searchable_type, :searchable_id])
      end.flatten
    end

    def namespace
      # This looks daft, but it gives us a foot in the door for when a frontend
      # search is triggered in the backend.
      return @namespace unless @namespace.nil?
      return 'Frontend' if controller.nil?
      controller.class.parent.to_s
    end

    # In order to provide a good result set in a search autocomplete, we have
    # to translate the raw index to a class that makes an index adhere
    # to a certain interface (that can include links).
    def result_object(index)
      klass = "Udongo::Search::ResultObjects::#{namespace}::#{index.searchable_type}"
      klass = 'Udongo::Search::ResultObject' unless result_object_exists?(klass)
      klass.constantize.new(index, search_context: self)
    end

    def result_object_exists?(name)
      class_exists?(name) && name.constantize.method_defined?(:build_html)
    end
  end
end
