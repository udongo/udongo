class Udongo::Search
  attr_reader :term

  def initialize(term)
    @term = term
  end

  def find
    puts indices.inspect

    # TODO: After we have a bunch of indices, we have to translate them into
    # meaningful links.
  end

  def indices
    # Having the searchmodules sorted by weight returns indices in the
    # correct order.
    SearchModule.weighted.inject([]) do |stack, m|
      stack << m.indices
    end.flatten
  end
end
