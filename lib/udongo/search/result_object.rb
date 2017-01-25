module Udongo::Search
  class InterfaceNotImplementedError < NoMethodError
  end

  class ResultObject
    attr_reader :index

    def initialize(index)
      @index = index
    end

    def build
      raise InterfaceNotImplementedError.new(
        "You need to define Udongo::Search::ResultObjects::#{index.searchable_type}#build in lib/udongo/search/result_objects/page.rb"
      )
    end
  end
end
