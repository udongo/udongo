module Concerns
  module Storable
    extend ActiveSupport::Concern

    included do
      has_many :stores, as: :storable, dependent: :destroy

      after_save do
        if @store_collections
          @store_collections.keys.each { |c| store(c).save }
        end
      end
    end

    def storable?
      true
    end

    def store(collection = :default)
      @store_collections = {} unless @store_collections

      unless @store_collections[collection.to_sym]
        @store_collections[collection.to_sym] = Concerns::Storable::Collection.new(
          self, collection, self.class.store_config
        )
      end

      @store_collections[collection.to_sym]
    end

    module ClassMethods
      def storable_field(name, type, default = nil)
        delegate name, "#{name}=", to: :store
        store_config.add name, type, default
      end

      def store_config
        @store_config ||= Concerns::Storable::Config.new
      end
    end
  end
end
