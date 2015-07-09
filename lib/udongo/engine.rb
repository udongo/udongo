module Udongo
  class Engine < ::Rails::Engine

    # Let Rails generators create FactoryGirl factories.
    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end
  end
end
