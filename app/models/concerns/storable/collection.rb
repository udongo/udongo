module Concerns
  module Storable
    class Collection
      def initialize(parent, category, config)
        @parent = parent
        @category = category
        @config = config

        init_attributes
        init_values
      end

      def delete
        stores.each { |s| s.destroy }
        reset_values
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

      def define_reader_method_for_uploader_field(field, options)
        self.class.send(:define_method, field) do
          StoreWithFile.mount_uploader :value, options[:type]
          store(field, file: true).value
        end
      end

      def define_writer_method_for_uploader_field(field, options)
        self.class.send(:define_method, "#{field}=") do |value|
          # Right now, when we save a form with a filefield, you will
          # notice in the database that the store value keeps updating
          # with a new filename hash. It always "reuploads" the file.
          s = store(field, file: true)
          s.value = value
          s.save
        end
      end

      private

      def init_attributes
        extend(Virtus.model)

        @config.fields.each do |field,options|
          if options[:type].to_s.include?('Uploader')
            define_reader_method_for_uploader_field(field, options)
            define_writer_method_for_uploader_field(field, options)
          else
            attribute field, options[:type], default: options[:default], lazy: true
          end
        end
      end

      def init_values
        stores.pluck(:name, :value).each do |field, value|
          next unless @config.allowed?(field)
          next if @config.fields[field.to_sym][:type].to_s.include?('Uploader')
          send "#{field}=", value
        end
      end

      def reset_values
        attributes.keys.each { |k| send("#{k}=", nil) }
        true
      end
    end
  end
end
