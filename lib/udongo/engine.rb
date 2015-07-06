module Udongo
  class Engine < ::Rails::Engine

    # Let Rails generators create FactoryGirl factories.
    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    initializer 'udongo.assets.precompile' do |app|
      glob_files("#{Udongo::PATH}/app/assets/javascripts/**/*.js") do |f|
        app.config.assets.precompile += [f.split('javascripts/').last]
      end
    end

    initializer 'vendor.assets.precompile' do |app|
      glob_files("#{Udongo::PATH}/vendor/assets/javascripts/**/*.js") do |f|
        app.config.assets.precompile += [f.split('javascripts/').last]
      end

      glob_files("#{Udongo::PATH}/vendor/assets/images/**/*") do |f|
        app.config.assets.precompile += [f.split('images/').last]
      end

      glob_files("#{Udongo::PATH}/vendor/assets/stylesheets/**/*") do |f|
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

    def glob_files(path, &block)
      Dir.glob(path).each do |f|
        next if File.directory?(f)
        yield f
      end
    end

  end
end
