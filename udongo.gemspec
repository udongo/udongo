$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'udongo/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'udongo'
  s.version     = Udongo::VERSION
  s.authors     = ['Davy Hellemans', 'Dave Lens']
  s.email       = %w(udongo@bauffman.be udongo@davelens.be)
  s.homepage    = 'http://udongo.be'
  s.summary     = 'Blimp CMS'
  s.description = 'Blimp CMS'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  # General
  s.add_dependency 'rails', '~> 4.2.1'
  s.add_dependency 'mysql2'

  # Javascript related
  s.add_dependency 'jquery-rails'
  s.add_dependency 'jquery-ui-rails'

  # Use SCSS for stylesheets
  s.add_dependency 'sass-rails', '~> 5.0.3'
  s.add_dependency 'foundation-rails', '~> 5.5.1'

  # Other
  s.add_dependency 'bcrypt', '~> 3.1.7'
  s.add_dependency 'simple_form'
  s.add_dependency 'acts_as_list'
  s.add_dependency 'country_select'
  s.add_dependency 'rmagick'
  s.add_dependency 'mini_magick'
  s.add_dependency 'carrierwave'
  s.add_dependency 'rakismet'
  s.add_dependency 'marked-rails'
  s.add_dependency 'reform'

  # Development dependencies
  s.add_development_dependency 'sqlite3'
end
