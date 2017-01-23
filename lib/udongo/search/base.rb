module Udongo::Search
  class Base
    attr_reader :term

    def initialize(term)
      @term = term
    end

    def find
      # TODO: After we have a bunch of indices, we have to translate them into
      # meaningful links.
      indices.each do |index|
        puts index.inspect
      end

      #searchable_models.each do |model|
        #model.constantize.new(indices).
      #end
    end

    def indices
      return [] unless term.present?

      # Having the searchmodules sorted by weight returns indices in the
      # correct order.
      @indices ||= SearchModule.weighted.inject([]) do |stack, m|
        stack << m.indices.where('search_indices.value REGEXP ?', term)
      end.flatten
    end

    # TODO: Perhaps this isn't necessary, but I'll leave it here until I'm sure.
    def searchable_models
      Dir.glob(File.join(Udongo::PATH, 'app/models/*.rb')).inject([]) do |stack, file|
        if File.readlines(file).grep(/include Concerns::Searchable/).any?
          filename = file.split('/').last

          if File.exists?(File.join(Udongo::PATH, 'lib/udongo/search/', filename))
            stack << filename.gsub('.rb', '')
          end
        end

        stack
      end
    end
  end
end
