# Due to the load order of classes, Backend precedes the required Base class.
require_relative 'base'

module Udongo::Search
  # The goal of this class is to provide a manipulated version of the filtered
  # index data that we can use in the result set of an autocomplete-triggered
  # search query. See Udongo::Search::Base for more information on how this
  # search functionality is designed.
  class Frontend < Udongo::Search::Base
    # This translates the filtered indices into meaningful result objects.
    # These require a { label: ... value: ... } to accommodate jquery-ui.
    #
    # Note that the result_object#url method is defined in
    # Udongo::Search::ResultObjects::Frontend::Page.
    #
    # If you return nil in the #url method of a result object, the item
    # will get filtered out of the search results.
    def search
      ::Search.create!(locale: controller.locale, term: term.value) if term

      indices.map do |index|
        result = result_object(index)
        next if result.hidden? || result.unpublished? || result.url.nil?
        { label: result.label, value: result.url }
      end.select(&:present?)
    end
  end
end
