module Concerns
  module Addressable
    extend ActiveSupport::Concern

    included do
      has_many :addresses, dependent: :destroy
    end

    module ClassMethods
      def configure_address(categories, default: nil)
        address_config.update(categories, default: default)
      end

      def address_config
        @address_config ||= Concerns::Addressable::Config.new
      end
    end

    def address(category = nil)
      category = self.class.address_config.default unless category.present?

      unless self.class.address_config.allowed?(category)
        raise "You can't select the '#{category}' address because it's not an allowed category"
      end

      @address_collections = {} unless @address_collections

      unless @address_collections[category.to_sym]

        @address_collections[category.to_sym] = Address.find_or_initialize_by(
          category: category,
          addressable_type: self.class.name,
          addressable_id: id
        )
      end

      @address_collections[category.to_sym]
    end
  end
end
