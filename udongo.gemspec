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
  s.description = 'Blimp CMS.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib,vendor}/**/*', 'spec/factories', 'spec/support/concerns', 'spec/features/**/*' 'MIT-LICENSE', 'Rakefile', 'readme.md', 'changelog.md']

  # General
  s.add_dependency 'rails', '5.0.0'

  # Javascript related
  s.add_dependency 'jquery-rails', '~> 4.0', '>= 4.0.5'
  s.add_dependency 'jquery-ui-rails', '~> 5.0', '>= 5.0.5'

  # Styling
  s.add_dependency 'sass-rails', '~> 5.0', '>= 5.0.3'

  # Other
  s.add_dependency 'bcrypt', '~> 3.1', '>= 3.1.7'
  s.add_dependency 'simple_form', '~> 3.1', '>= 3.1.1'
  s.add_dependency 'acts_as_list', '~> 0.7', '>= 0.7.2'
  s.add_dependency 'country_select', '~> 2.4', '>= 2.4.0'
  s.add_dependency 'rmagick', '~> 2.15', '>= 2.15.4'
  s.add_dependency 'mini_magick', '~> 4.3', '>= 4.3.6'
  s.add_dependency 'carrierwave', '~> 0.10', '>= 0.10.0'
  s.add_dependency 'redcarpet', '~> 3.3', '>= 3.3.3'
  s.add_dependency 'draper', '3.0.0.pre1'
  s.add_dependency 'ransack', '~> 1.7', '>= 1.7.0'
  s.add_dependency 'responders', '~> 2.1', '>= 2.1.0'
  s.add_dependency 'ckeditor', '~> 4.1', '>= 4.1.4'
  s.add_dependency 'will_paginate', '~> 3.0', '>= 3.0.6'
  s.add_dependency 'virtus', '~> 1.0', '>= 1.0.5'

  # Development dependencies
  s.add_development_dependency 'mysql2', '~> 0.3.20'
  s.add_development_dependency 'sqlite3', '~> 1.3', '>= 1.3.11'
  s.add_development_dependency 'spring', '~> 1.6', '>= 1.6.4'
end
