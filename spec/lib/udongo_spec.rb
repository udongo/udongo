require 'rails_helper'

describe Udongo do
  it '.config' do
    expect(Udongo.config.class).to eq Udongo::Config
  end

  it '.reset_config' do
    Udongo.config.base.host = :foo
    Udongo.reset_config
    expect(Udongo.config.base.host).to eq 'udongo.dev'
  end

  it '.respond_to?' do
    expect(Udongo).to respond_to(:config, :reset_config, :configure)
  end
end
