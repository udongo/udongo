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
  s.summary     = 'Modular CMS'
  s.description = 'Module CMS'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'rails', '~> 4.2.1'

  s.add_development_dependency 'sqlite3'
end
