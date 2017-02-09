module Udongo
  class InterfaceNotImplementedError < NoMethodError
  end

  module Search
    module ResultObjects
      class Base
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
          unless File.exists?(full_partial)
            raise(InterfaceNotImplementedError, "In order to display formatted HTML for search results, the build_html method expects for a partial to exist in #{full_partial}")
          end

          ApplicationController.render(partial: partial, locals: locals)
        end

        def full_partial
          root = Rails.root.to_s.gsub('spec/dummy', '')
          File.join(root, 'app/views', partial_path, "_#{partial_target}.html.erb")
        end

        def hidden?
          searchable.respond_to?(:visible) && searchable.hidden?
        end

        def label
          if index.name.include?('flexible_content')
            id = index.name.split(':')[1].to_i
            return ContentText.find(id).content
          end

          searchable.send(index.name)
        end

        def locals
          { "#{partial_target}": index.searchable, index: index }
        end

        def partial
          "#{partial_path}/#{partial_target}"
        end

        def partial_path
          "#{search_context.namespace.to_s.underscore}/search/result_rows"
        end

        def partial_target
          index.searchable_type.underscore
        end

        def unpublished?
          searchable.respond_to?(:published?) && searchable.unpublished?
        end
      end
    end
  end
end
