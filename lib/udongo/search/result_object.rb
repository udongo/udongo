module Udongo::Search
  class InterfaceNotImplementedError < NoMethodError
  end

  class ResultObject
    attr_reader :index, :search_context

    delegate :searchable, to: :index

    def initialize(index, search_context: nil)
      @index = index
      @search_context = search_context
    end

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
    def build_html
      ApplicationController.render(partial: partial, locals: locals)
    end

    def label
      searchable.send(index.name)
    end

    def locals
      { "#{partial_target}": index.searchable, index: index }
    end

    def partial
      "#{search_context.namespace.underscore}/search/result_rows/#{partial_target}"
    end

    def partial_target
      index.searchable_type.underscore
    end
  end
end
