module Udongo::Search::ResultObjects
  class Page < Udongo::Search::ResultObject
    # This class should be used to perform further mutations on any of the data
    # provided in Udongo::Search::ResultObject. A controller context class
    # is accessible through #controller in order to have access to routes.
    # The #namespace method is there to help you differentiate values between
    # frontend, backend or other namespaces.
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
