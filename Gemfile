source 'https://rubygems.org'

# Declare your gem's dependencies in udongo.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

group :test do
  gem 'launchy'
  gem 'database_cleaner'
  gem 'codeclimate-test-reporter', '~> 0.5.0', require: nil
  gem 'capybara', '~> 2.5.0'
  gem 'webmock', '~> 1.22.3'
  gem 'capybara-webkit', '~> 1.8.0'
end

group :test, :development do
  gem 'spring-commands-rspec', '~> 1.0.4'
  gem 'rspec-rails', '~> 3.4.0'
  gem 'guard-rspec', '~> 4.6.4'
  gem 'factory_girl_rails', require: false
  gem 'rb-fsevent' if `uname` =~ /Darwin/
  gem 'letter_opener', '~> 1.4.1'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
end
