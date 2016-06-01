module Concerns
  module Storable
    class Collection
      def initialize(parent, category, config)
        @parent = parent
        @category = category

        init_attributes(config)
        init_values(config)
      end

      def save
        attributes.each do |name,value|
          tmp = ::Store.find_or_initialize_by(
            collection: @category,
            storable_type: @parent.class.name,
            storable_id: @parent.id,
            name: name
          )

          tmp.value = value
          tmp.save!
        end
      end

      def delete
        ::Store.where(
          storable_type: @parent.class,
          storable_id: @parent.id,
          collection: @category,
        ).each { |s| s.destroy }

        reset_values
      end

      private

      def init_attributes(config)
        extend(Virtus.model)

        config.fields.each do |field,options|
          attribute field, options[:type], default: options[:default], lazy: true
        end
      end

      def init_values(config)
        ::Store.where(
          storable_type: @parent.class,
          storable_id: @parent.id,
          collection: @category,
        ).pluck(:name, :value).each do |field, value|
          send "#{field}=", value if config.allowed?(field)
        end
      end

      def reset_values
        attributes.keys.each { |k| send("#{k}=", nil) }
      end
    end
  end
end
