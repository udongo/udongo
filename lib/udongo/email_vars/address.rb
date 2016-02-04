module Udongo
  module EmailVars
    class Address
      def initialize(address)
        @address = address
      end

      def to_hash(prefix: 'address')
        {
          "#{prefix}.street": @address.street,
          "#{prefix}.number": @address.number,
          "#{prefix}.postal": @address.postal,
          "#{prefix}.city": @address.city,
          "#{prefix}.country": @address.country
        }
      end
    end
  end
end
