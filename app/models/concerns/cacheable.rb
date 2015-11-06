module Concerns
  module Cacheable
    extend ActiveSupport::Concern

    included do
      after_save :flush_cache

      scope :find_in_cache, ->(value) {
        Rails.cache.fetch([name, value]) do
          o = find_by!(@cache_field => value)

          if o.respond_to?(:translatable) && o.translatable?
            Udongo.config.locales.each do |l|
              name.constantize.translation_config.fields.each { |f| o.translation(l).send(f) }
            end
          end

          o
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
