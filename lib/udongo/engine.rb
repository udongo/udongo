module Udongo
  class Engine < ::Rails::Engine

    # Let Rails generators create FactoryGirl factories.
    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    initializer 'udongo.assets.precompile' do |app|
      Dir.glob("#{Rails.root}/../../app/assets/javascripts/backend/*.js").each do |f|
        app.config.assets.precompile += ["backend/#{f.split('backend/').last}"]
      end
    end
  end
end
