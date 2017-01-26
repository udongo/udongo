# Due to the load order of classes, Backend precedes the required Base class.
require_relative 'base'

module Udongo::Search
  # The goal of this class is to provide a manipulated version of the filtered
  # index data that we can use in the result set of an autocomplete-triggered
  # search query. See Udongo::Search::Base for more information on how this
  # search functionality is designed.
  class Backend < Udongo::Search::Base
    def search
      # Translate the filtered indices into meaningful result objects.
      # These require a { label: ... value: ... } to accommodate jquery-ui.
      #
      # TODO: Obviously, not every searchable will have a page link.
      # This requires a factory pattern based on searchable_type to determine
      # the correct values.
      indices.map do |index|
        {
          label: result_object(index).build_html(namespace: :backend),
          value: controller.edit_backend_page_path(index.searchable)
        }
      end
    end
  end
end
