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
        "Search index ##{index.id} requires you to define Udongo::Search::ResultObjects::#{index.searchable_type}#build"
      )
    end
  end
end
