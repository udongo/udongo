#Rails.application.config.assets.precompile += Ckeditor.assets
require 'udongo/assets/precompiler'

precompiler = Udongo::Assets::Precompiler.new Rails.application
precompiler.add_javascript 'app/assets/javascripts/**/*.js'
precompiler.add_javascript 'vendor/assets/javascripts/**/*.js'

precompiler.add_images 'app/assets/images/**/*'
precompiler.add_images 'vendor/assets/images/**/*'

precompiler.add_stylesheets 'app/assets/images/**/*'
precompiler.add_stylesheets 'vendor/assets/images/**/*'
