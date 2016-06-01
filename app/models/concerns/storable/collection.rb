module Concerns
  module Storable
    class Collection
      def initialize(parent, category)
        @parent = parent
        @category = category
      end

      # TODO the 'klass' field is not required in the db.
      def save
        attributes.each do |name,value|
          tmp = ::Store.find_or_initialize_by(
            collection: @category,
            storable_type: @parent.class.name,
            storable_id: @parent.id,
            klass: 'FooBar',
            name: name
          )

          tmp.value = value
          tmp.save!
        end
      end
    end
  end
end
