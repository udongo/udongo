require_relative '../base'

module Udongo::Search::ResultObjects
  module Frontend
    # This class should be used to further manipulate any of the data provided
    # through #search_context or Udongo::Search::ResultObjects::Base.
    #
    # A search context class is accessible through #search_context. This
    # gives you access to #search_context.controller, which can be used to
    # call routes upon.
    #
    # Example of: If an autocomplete requires additional data to be rendered in
    # the partial (think another model, or an API call), one could override
    # the #locals method to include more variables. You could do this directly
    # in the partial as well, but this way we have separation of concerns.
    class Page < Udongo::Search::ResultObjects::Base
      def url
        # TODO: We don't have methods to build frontend URLs for pages yet?
      end
    end
  end
end
