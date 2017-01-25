module Udongo::Search::ResultObjects
  class Page < Udongo::Search::ResultObject
    # Typically, an autocomplete requires 3 things:
    #
    # * A title indicating a resource name.
    #   Examples: Page#title, Product#name,...
    # * A truncated summary providing a glimpse of the resource's contents.
    #   Examples: Page#subtitle, Product#description,...
    # * A link to the resource.
    #   Examples: edit_backend_page_path(37), product_path(37),...
    #
    # However, this seems very restrictive to me. If I narrow down the data
    # a dev can use in an autocomplete, it severely reduces options he/she has
    # in how the autocomplete results look like. Think of autocompletes in a
    # shop that require images or prices to be included in their result bodies.
    #
    # This is why I chose to let ApplicationController.render work around the
    # problem by letting the dev decide how the row should look.
    #
    # Now, a frontend search query could build a series of said partial renders
    # in order to build its result set. If a lot of mutation is required, this
    # could also be achieved in this class, with the possibility of testing
    # those mutations.
    #
    # TODO: Move the build method to Udongo::Search::ResultObject? This way,
    # only a partial would be required as a minimum in order to provide
    # HTML result rows for use in an autocomplete.
    def build
      partial_target = index.class.name.underscore
      partial = "backend/search/result_rows/#{partial_target}"
      ApplicationController.render(partial: partial, locals: { "#{partial_target}": index })
    end
  end
end
