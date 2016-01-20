class Udongo::ContactFormGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def class_name
    'Frontend::ContactForm'
  end

  def destination_file
    'app/forms/frontend/contact_form.rb'
  end

  def generate_form_class
    'app/forms/frontend/contact_form.rb'
    say_status 'OK', 'Copying to app/forms/frontend/contact_form', :yellow
    copy_file 'form.rb', destination_file
    gsub_file destination_file, 'klass', class_name
    gsub_file destination_file, 'form_name', 'contact'
	end

  def create_database_records
    f = ::Form.create!(name: 'contact', locales: Udongo.config.locales)
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
