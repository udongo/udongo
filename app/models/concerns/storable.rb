module Concerns
  module Storable
    extend ActiveSupport::Concern

    included do
      has_many :stores, as: :storable, dependent: :destroy
      after_save { store.save }
    end

    def storable?
      true
    end

    def store(collection = :default)
      @store_collections = {} unless @store_collections

      collection = collection.to_sym

      unless @store_collections[collection]
        @store_collections[collection] = Concerns::Storable::Collection.new(
          self, collection
        )

        @store_collections[collection].extend(Virtus.model)

        # create all attributes
        self.class.store_config.fields.each do |field,options|
          @store_collections[collection].attribute field, options[:type], default: options[:default], lazy: true
        end

        # set all values
        stores.where(collection: collection).pluck(:name, :value).each do |field,value|
          if self.class.store_config.allowed?(field)
            @store_collections[collection].send("#{field}=", value)
          end
        end
      end

      @store_collections[collection]
    end

    module ClassMethods
      def storable_field(name, type, default = nil)
        delegate name, to: :store
        delegate "#{name}=", to: :store
        store_config.add name, type, default
      end

      def store_config
        @store_config ||= Concerns::Storable::Config.new
      end
    end
  end
end
