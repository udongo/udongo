module Udongo::Search::ResultObjects
  class Page < Udongo::Search::ResultObject
    # TODO: How will I structure a result object?
    #
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
    # A possible solution to the above:
    # If one would use ActionController.render('', locals: { index: index })
    # in this class to map the entire index instance to a user-defined partial
    # that represents a single result row in an autocomplete, a frontend
    # search query could build a series of said partial renders in order
    # to build its result set. If a lot of mutation is required, this could
    # also be achieved in this class, with the possibility of testing those
    # mutations.
  end
end
