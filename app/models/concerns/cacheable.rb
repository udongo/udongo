module Concerns
  module Cacheable
    extend ActiveSupport::Concern

    included do
      after_save :flush_cache

      scope :find_in_cache, ->(value) do
        Rails.cache.fetch([name, value]) { find_by!(@cache_field => value) }
      end
    end

    module ClassMethods
      def cache_by(field)
        @cache_field = field

        define_method(:flush_cache) do
          Rails.cache.delete [self.class.name, self.send(field)]
        end
      end
    end
  end
end
