module Udongo
  class Engine < ::Rails::Engine

    # Let Rails generators create FactoryGirl factories.
    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    initializer 'udongo.assets.precompile' do |app|
      Dir.glob("#{Udongo::PATH}/app/assets/javascripts/**/*.js").each do |f|
        app.config.assets.precompile += [f.split('javascripts/').last]
      end
    end

    initializer 'vendor.assets.precompile' do |app|
      Dir.glob("#{Udongo::PATH}/vendor/assets/javascripts/**/*.js").each do |f|
        app.config.assets.precompile += [f.split('javascripts/').last]
      end
      Dir.glob("#{Udongo::PATH}/vendor/assets/images/**/*").each do |f|
        app.config.assets.precompile += [f.split('images/').last]
      end
      Dir.glob("#{Udongo::PATH}/vendor/assets/stylesheets/**/*").each do |f|
        filename = f.split('stylesheets/').last.split('.')
        extension = filename.slice!(-1)
        filename = filename.join('.')
        app.config.assets.precompile += ["#{filename}.css"] if extension == 'scss'
        app.config.assets.precompile += ["#{filename}.scss"] if extension == 'css'
      end
    end
  end
end
