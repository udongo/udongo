require 'rails_helper'

describe Udongo::Configs::Routes do
  let(:klass) { described_class }
  let(:instance) { klass.new }

  describe 'defaults' do
    it :prefix_with_locale do
      expect(klass.new.prefix_with_locale).to eq true
    end
  end

  describe '#prefix_with_locale' do
    it :true do
      instance.prefix_with_locale = true
      expect(instance).to be_prefix_with_locale
    end

    it :false do
      instance.prefix_with_locale = false
      expect(instance).not_to be_prefix_with_locale
    end
  end

  it '#respond_to?' do
    expect(klass.new).to respond_to(
      :prefix_with_locale, :prefix_with_locale=, :prefix_with_locale?
    )
  end
end
