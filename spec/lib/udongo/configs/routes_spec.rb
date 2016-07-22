require 'rails_helper'

describe Udongo::Configs::Routes do
  let(:klass) { described_class }

  describe 'defaults' do
    it :prefix_with_locale do
      expect(klass.new.prefix_with_locale).to eq true
    end
  end

  it '#respond_to?' do
    expect(klass.new).to respond_to(:prefix_with_locale, :prefix_with_locale=)
  end
end
