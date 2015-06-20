module Udongo
  class Engine < ::Rails::Engine

    # Let Rails generators create FactoryGirl factories.
    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    initializer 'udongo.assets.precompile' do |app|
      Dir.glob("#{Udongo::PATH}/app/assets/javascripts/**/*.js").each do |f|
        next if File.directory?(f)
        app.config.assets.precompile += [f.split('javascripts/').last]
      end
    end

    initializer 'vendor.assets.precompile' do |app|
      Dir.glob("#{Udongo::PATH}/vendor/assets/javascripts/**/*.js").each do |f|
        next if File.directory?(f)
        app.config.assets.precompile += [f.split('javascripts/').last]
      end

      Dir.glob("#{Udongo::PATH}/vendor/assets/images/**/*").each do |f|
        next if File.directory?(f)
        app.config.assets.precompile += [f.split('images/').last]
      end

      #raise Dir.glob("#{Udongo::PATH}/vendor/assets/stylesheets/**/*").inspect
      Dir.glob("#{Udongo::PATH}/vendor/assets/stylesheets/**/*").each do |f|
        next if File.directory?(f)

        filepath = f.split('stylesheets/').last
        filename = filepath.split('.')
        extension = filename.slice!(-1)
        filename = filename.join('.')

        if extension == 'scss'
          app.config.assets.precompile += ["#{filename}.css"]
        else
          app.config.assets.precompile += [filepath]
        end
      end
    end
  end
end
