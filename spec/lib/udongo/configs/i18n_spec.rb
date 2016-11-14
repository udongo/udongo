require 'rails_helper'

describe Udongo::Configs::I18n do
  let(:klass) { described_class }

  it '#app' do
    expect(klass.new.app).to be_a(Udongo::Configs::I18ns::App)
  end

  it '#cms' do
    expect(klass.new.cms).to be_a(Udongo::Configs::I18ns::Cms)
  end

  it '#respond_to?' do
    expect(klass.new).to respond_to(:app, :cms)
  end
end
