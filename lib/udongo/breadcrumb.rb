
module Udongo
  class Breadcrumb
    def initialize
      @items = []
    end

    def all
      @items
    end

    def add(name, link = nil)
      @items << { name: name, link: link }
    end

    def any?
      @items.any?
    end

    def each
      raise 'Block expected' unless block_given?

      if block_given?
        @items.each { |i| yield(i) }
      end
    end
  end
end
