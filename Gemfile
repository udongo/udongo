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
  gem 'launchy', '~> 2.4.3'
  gem 'database_cleaner', '~> 1.7.0'
  gem 'capybara', '~> 2.7.1'
  gem 'webmock', '~> 1.22.3'
end

group :test, :development do
  gem 'spring-commands-rspec', '~> 1.0.4'
  gem 'rspec-rails', '~> 3.5.1'
  gem 'guard-rspec', '~> 4.6.4'
  gem 'factory_girl_rails', '~> 4.7.0', require: false
  gem 'rb-fsevent', '~> 0.9.7' if `uname` =~ /Darwin/
  gem 'letter_opener', '~> 1.4.1'
end

group :development do
  gem 'better_errors', '~> 2.1.1'
  gem 'binding_of_caller', '~> 0.7.2'
  gem 'rack-mini-profiler', '~> 0.10.1'
end
