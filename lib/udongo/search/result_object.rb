module Udongo::Search
  class InterfaceNotImplementedError < NoMethodError
  end

  class ResultObject
    attr_reader :index

    def initialize(index)
      @index = index
    end

    def build_html
      raise InterfaceNotImplementedError.new(
        "You need to define Udongo::Search::ResultObjects::#{index.searchable_type}#build_html in lib/udongo/search/result_objects/#{index.searchable_type.underscore}.rb"
      )
    end
  end
end
