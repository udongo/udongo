class Udongo::ContactFormGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def destination_file
    'app/forms/frontend/contact_form.rb'
  end

	def generate_reform_class
    'app/forms/frontend/contact_form.rb'
    say_status 'OK', 'Copying to app/forms/frontend/contact_form', :yellow
    copy_file 'reform.rb', destination_file
    gsub_file destination_file, 'klass', 'Frontend::ContactForm'
	end

  def create_database_records
    f = ::Form.create!(name: 'contact', locales: Udongo.config.locales)
    name = f.fields.create!(name: 'name', field_type: 'text')
    name.validations.create!(validation_class: 'Udongo::FormValidations::Required')
    email = f.fields.create!(name: 'email', field_type: 'email')
    email.validations.create!(validation_class: 'Udongo::FormValidations::Email')
    message = f.fields.create!(name: 'message', field_type: 'textarea')
    message.validations.create!(validation_class: 'Udongo::FormValidations::Required')

    f.fields.each do |field|
      inject_into_file destination_file, after: "model :form_submission\n\n" do
        <<-"RUBY"
  property :#{field.name}
        RUBY
      end
		end
  end
end
