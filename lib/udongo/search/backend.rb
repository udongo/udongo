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
      indices.map do |index|
        result_object(index).build
      end
    end
  end
end
