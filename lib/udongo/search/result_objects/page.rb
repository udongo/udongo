module Udongo::Search::ResultObjects
  class Page < Udongo::Search::ResultObject
    # This class could be used to perform further mutations on any of the data
    # provided in Udongo::Search::ResultObject.
    #
    # Example: If an autocomplete requires data from an external source
    # or another, unrelated model to be rendered in the partial, one could
    # override the #locals method to include more variables.
    # You could do this directly in the partial as well, but this provides us
    # separation of concerns and testability.
    #
    #def build_html
    #  super(*args)
    #end
  end
end
