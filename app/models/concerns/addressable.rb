module Concerns
  module Addressable
    extend ActiveSupport::Concern

    included do
      has_many :addresses, dependent: :destroy
    end

    module ClassMethods
      def address_categories(categories, default: 'default')
      end
    end
  end
end
