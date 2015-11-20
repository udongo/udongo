require 'rails_helper'

describe Udongo::Config do
  let(:instance) { Udongo::Config.new }

  describe 'defaults' do
    it :default_locale do
      expect(instance.default_locale).to eq :nl
    end

    it :locales do
      expect(instance.locales).to eq %w(nl en fr de)
    end

    it :host do
      expect(instance.host).to eq 'udongo.dev'
    end

    it :time_zone do
      expect(instance.time_zone).to eq 'Brussels'
    end

    it :prefix_routes_with_locale do
      expect(instance.prefix_routes_with_locale).to eq true
    end

    it :allow_new_tags do
      expect(instance.allow_new_tags).to eq true
    end
  end

  it '#respond_to?' do
    expect(instance).to respond_to(
      :default_locale, :default_locale=, :host, :host=, :time_zone, :time_zone=,
      :locales, :locales=, :prefix_routes_with_locale, :prefix_routes_with_locale=,
      :prefix_routes_with_locale?, :allow_new_tags, :allow_new_tags=, :allow_new_tags?
    )
  end
end
