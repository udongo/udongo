require 'rails/generators/generated_attribute'

class Udongo::FormGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :name, type: :string, required: true, banner: 'name'
  argument :namespace, type: :string, banner: 'app namespace', default: 'frontend'

  class_option :fields, type: :string, required: true, banner: 'field_name:type', desc: 'Creates the specified form fields for this form.'

  def initialize(*args, &block)
    super
    filter_fields
  end

  def class_name
    "#{namespace.camelcase}::#{name.camelcase}Form"
  end

  def copy_form_class
    say_status 'OK', "Copying to #{destination_file}", :yellow
    copy_file 'form.rb', destination_file
    gsub_file destination_file, 'klass', class_name
    gsub_file destination_file, 'form_name', name
  end

  def create_database_records
    f = ::Form.create!(locales: Udongo.config.locales, identifier: name)

    @fields.each do |field|
      field_object = f.fields.create!(locales: Udongo.config.locales, name: field.name, field_type: field.type)
      # TODO: validations
      #field_object.validations.create!(locales: Udongo.config.locales, validation_class: 'Udongo::FormValidations::Required')
    end

    inject_into_file destination_file, after: "class #{class_name} < Udongo::ActiveModelSimulator\n" do
      <<-RUBY
  attr_accessor :#{f.fields.map(&:name).join(', :')}
      RUBY
    end
  end

  def destination_file
    "app/forms/#{namespace.underscore}/#{name.underscore}_form.rb"
  end

  def filter_fields
    @fields = options.fields.split(',').inject([]) do |fields, f|
      if f.to_s.include?(':')
        attr = f.split(':')[0]
        type = f.split(':')[1].to_sym
      else
        attr = f
        type = :text
      end

      fields << Rails::Generators::GeneratedAttribute.new(attr, type)
    end
  end

  def fields
    @fields || []
  end
end
