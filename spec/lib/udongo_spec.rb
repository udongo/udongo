require 'rails_helper'

describe Udongo do
  it '.config' do
    expect(Udongo.config.class).to eq Udongo::Config
  end

  it '.reset_config' do
    Udongo.config.default_locale = :foo
    Udongo.reset_config
    expect(Udongo.config.default_locale).to eq :nl
  end

  it '.respond_to?' do
    expect(Udongo).to respond_to(:config, :reset_config, :configure)
  end
end
