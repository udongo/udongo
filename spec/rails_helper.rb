ENV['RAILS_ENV'] ||= 'test'

# require 'rails_helper'
require File.expand_path('../dummy/config/environment', __FILE__)
require 'rspec/rails'
require 'factory_girl_rails'

WebMock.disable_net_connect!(allow: %w{codeclimate.com})

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
Dir[Rails.root.join('../support/**/*.rb')].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order = 'random'

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) { DatabaseCleaner.start }
  config.after(:each) { DatabaseCleaner.clean }

  # Allow the short syntax
  config.include FactoryGirl::Syntax::Methods

  # Capybara DSL
  config.include Capybara::DSL

  # Makes methods available based on file type (ie. post/get in controller specs)
  config.infer_spec_type_from_file_location!

  # Remove temporarily uploaded files
  config.after(:each) do
    if Rails.env.test? || Rails.env.cucumber?
      FileUtils.rm_rf(Dir["#{Rails.root}/spec/support/uploads"])
    end
  end
end

FactoryGirl::SyntaxRunner.class_eval do
  include ActionDispatch::TestProcess
end
