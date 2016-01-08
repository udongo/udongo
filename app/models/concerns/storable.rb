module Concerns
  module Storable
    extend ActiveSupport::Concern

    included do
      has_many :stores, as: :storable, dependent: :destroy
      after_save { store.save }
    end

    def store
      @store_collection ||= Concerns::Storable::Collection.new(
        self, self.class.store_config
      )
    end

    def storable?
      true
    end

    module ClassMethods
      def storable_field(name, klass, default = nil)
        delegate name, to: :store
        delegate "#{name}=", to: :store
        store_config.add(name, klass, default)
      end

      def store_config
        @store_config ||= Concerns::Storable::Config.new
      end
    end
  end
end
