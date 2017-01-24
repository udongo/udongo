# Due to the load order of classes, Backend precedes the required Base class.
require_relative 'base'

module Udongo::Search
  # The goal of this class is to provide a manipulated version of the filtered
  # index data that we can use in the result set of an autocomplete-triggered
  # search query. See Udongo::Search::Base for more information on how this
  # search functionality is designed.
  class Backend < Udongo::Search::Base
    def find
      # Translate the filtered indices into meaningful result objects.
      indices.map do |index|
        result_object(index).build
      end
    end


    # In order to provide a good result set in a search autocomplete, we have
    # to translate the raw index to a class that makes an index adhere
    # to a certain interface (that can include links).
    def result_object(index)
      klass = "Udongo::Search::ResultObjects::#{index.searchable_type}"
      klass.constantize.new(index)
    end
  end
end
