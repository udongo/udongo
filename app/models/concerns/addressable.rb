module Concerns
  module Addressable
    extend ActiveSupport::Concern

    included do
      has_many :addresses, dependent: :destroy
    end

    module ClassMethods
      def address_categories(categories, default: nil)
        # TODO move these to a Addressable::Config just like storable
        # @address_categories = categories.map(&:to_sym)
        # @default_address_category = default.present? ? default.to_sym : @address_categories.first
      end
    end

    def address(category = nil)
      # category given?
      # category allowed?
      # find or initialize
      # make sure to only find/initialize once
    end
  end
end
