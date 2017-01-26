module Concerns
  module Cacheable
    extend ActiveSupport::Concern

    included do
      after_save :flush_cache
      after_touch :flush_cache

      scope :find_in_cache, ->(value) {
        Rails.cache.fetch [name, value] do
          find_by!(@cache_field => value)
        end
      }
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
