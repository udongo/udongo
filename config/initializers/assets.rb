#Rails.application.config.assets.precompile += Ckeditor.assets
require 'udongo/assets/precompiler'
require 'udongo/assets/loader'

precompiler = Udongo::Assets::Precompiler.new Rails.application
precompiler.add :javascripts, 'app/assets/javascripts/**/*.js'
precompiler.add :javascripts, 'vendor/assets/javascripts/**/*.js'

precompiler.add :images, 'app/assets/images/**/*'
precompiler.add :images, 'vendor/assets/images/**/*'

precompiler.add :stylesheets, 'app/assets/images/**/*'
precompiler.add :stylesheets, 'vendor/assets/images/**/*'
