class Udongo::FormGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :name, type: :string, required: true, banner: 'name'
  argument :namespace, type: :string, banner: 'app namespace', default: 'frontend'

  def class_name
    "#{namespace.camelcase}::#{name.camelcase}Form"
  end

  def destination_file
    "app/forms/#{namespace.underscore}/#{name.underscore}_form.rb"
  end

  def generate_form_class
    say_status 'OK', "Copying to #{destination_file}", :yellow
    copy_file 'form.rb', destination_file
    gsub_file destination_file, 'klass', class_name
    gsub_file destination_file, 'form_name', name
	end

  def create_database_records
    f = ::Form.create!(name: name, locales: Udongo.config.locales)
    name = f.fields.create!(name: 'name', field_type: 'text')
    name.validations.create!(validation_class: 'Udongo::FormValidations::Required')
    email = f.fields.create!(name: 'email', field_type: 'email')
    email.validations.create!(validation_class: 'Udongo::FormValidations::Email')
    message = f.fields.create!(name: 'message', field_type: 'textarea')
    message.validations.create!(validation_class: 'Udongo::FormValidations::Required')

    inject_into_file destination_file, after: "class #{class_name} < Udongo::ActiveModelSimulator\n" do
      <<-"RUBY"
  attr_accessor :#{f.fields.map(&:name).join(', :')}
      RUBY
    end
  end
end
