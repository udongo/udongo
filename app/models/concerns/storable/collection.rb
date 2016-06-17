module Concerns
  module Storable
    class Collection
      def initialize(parent, category, config)
        @parent = parent
        @category = category
        @config = config

        init_attributes(config)
        init_values(config)
      end

      def save
        attributes.each do |name,value|
          tmp = store(name)
          tmp.value = value
          tmp.save!
        end
      end

      def store(name, file: false)
        stores(file: file).find_or_initialize_by(name: name)
      end

      # You'll find that mounting an uploader on Store will prevent
      # the saving of other attributes.
      def stores(file: false)
        klass = file ? StoreWithFile : Store
        klass.where(storable: @parent, collection: @category)
      end

      def delete
        stores.each { |s| s.destroy }
        reset_values
      end

      private

      def init_attributes(config)
        extend(Virtus.model)

        config.fields.each do |field,options|
          if options[:type].to_s.include?('Uploader')
            self.class.send(:define_method, field) do
              ::StoreWithFile.mount_uploader :value, options[:type]
              store(field, file: true).value
            end
            self.class.send(:define_method, "#{field}=") do |value|
              s = store(field, file: true)
              s.value = value
              s.save
            end
          else
            attribute field, options[:type], default: options[:default], lazy: true
          end
        end
      end

      def init_values(config)
        stores.pluck(:name, :value).each do |field, value|
          next if @config.fields[field.to_sym][:type].to_s.include?('Uploader')
          send "#{field}=", value if config.allowed?(field)
        end
      end

      def reset_values
        attributes.keys.each { |k| send("#{k}=", nil) }
        true
      end
    end
  end
end
