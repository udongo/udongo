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
      # The result_object#url method will be nil by default, unless it's
      # overridden in a specific result object.
      indices.map do |index|
        result = result_object(index)
        { label: result.build_html, value: result.url }
      end
    end
  end
end
