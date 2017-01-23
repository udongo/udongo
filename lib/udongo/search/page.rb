module Udongo::Search
  class Page
    attr_reader :indices

    def initialize(indices)
      @indices = indices
    end
  end
end
